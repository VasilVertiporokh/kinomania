//
//  MoviesManager.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import Foundation
import Factory


// MARK: - MovieManagerObserver
protocol MovieManagerObserver: AnyObject {
    func movieManager(_ movieManager: MoviesManager, didFetch movies: [MoviesDomainModel])
    func movieManager(_ movieManager: MoviesManager, didChange filter: Filter)
    func movieManager(_ movieManager: MoviesManager, didFetch details: MoviewDetailsDomainModel)
    func movieManager(_ movieManager: MoviesManager, didFail error: Error)
}

extension MovieManagerObserver {
    func movieManager(_ movieManager: MoviesManager, didFetch movies: [MoviesDomainModel]) { }
    func movieManager(_ movieManager: MoviesManager, didChange filter: Filter) { }
    func movieManager(_ movieManager: MoviesManager, didFetch details: MoviewDetailsDomainModel) { }
}

enum MoviesManagerEvent {
    case genresDidFetch
    case moviesDidFetch([MoviesDomainModel])
    case detailsDidFetch(MoviewDetailsDomainModel)
    case filterDidUpdate(Filter)
    case error(Error)
}

// MARK: - MoviesManager protocol
protocol MoviesManager: AnyObject {
    var movies: [MoviesDomainModel] { get }
    var currentPage: Int { get }
    var currentFilter: Filter { get }
    var totalPages: Int { get }
    var isConnected: Bool { get }

    func subscribe(_ subscriber: MovieManagerObserver)
    func unsubscribe(_ subscriber: MovieManagerObserver)
    func fetchInitialMovies()
    func fetchMovies()
    func setFilter(filter: Filter)
    func getMovieDetails(id: Int)
    func searchMovie(name: String)
    func reloadData()
}

final class MoviesManagerImpl {
    // MARK: - Dependecy
    @Injected(\.moviesNetworkService) private var moviesNetworkService
    @Injected(\.reachabilityManager) private var reachabilityManager

    // MARK: - Internal properties
    private(set) var movies: [MoviesDomainModel] = []
    private(set) var currentPage: Int = 1
    private(set) var totalPages: Int = 0
    private(set) var currentFilter: Filter = .popularity
    private(set) var isConnected: Bool = true

    // MARK: - Private properties
    private var subscribers: [MovieManagerObserver] = []
    private var genres: [GenresResponseModel] = []
    private var isLoadingInProgress: Bool = false
    private var searchWorkItem: DispatchWorkItem?

    // MARK: - Init
    init() {
        reachabilityManager.reachabilityDelegate = self
    }
}

// MARK: - MoviesManager
extension MoviesManagerImpl: MoviesManager {
    func subscribe(_ subscriber: MovieManagerObserver) {
        subscribers.append(subscriber)
    }

    func unsubscribe(_ subscriber: MovieManagerObserver) {
        subscribers.removeAll(where: { $0 === subscriber })
    }

    func fetchInitialMovies() {
        guard isConnected else { return }
        moviesNetworkService.getGenres { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let genresList):
                self.genres = genresList.genres
                self.fetchMovies()
            case .failure(let error):
                self.notify(for: .error(error))
            }
        }
    }

    func fetchMovies() {
        guard !isLoadingInProgress && isConnected else { return }
        isLoadingInProgress = true
        moviesNetworkService.getMovies(pageNumber: "\(currentPage)", filter: currentFilter) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let movies):
                let moviesList = movies.results
                    .map { MoviesDomainModel(genres: self.genres, moviesResponseModel: $0) }
                self.movies.append(contentsOf: moviesList)
                self.notify(for: .moviesDidFetch(self.movies))
                self.currentPage += 1
                self.totalPages = movies.totalPages
                self.isLoadingInProgress = false
            case .failure(let error):
                self.notify(for: .error(error))
                self.isLoadingInProgress = false
            }
        }
    }

    func setFilter(filter: Filter) {
        notify(for: .filterDidUpdate(filter))
        movies = []
        currentPage = 1
        currentFilter = filter
        fetchMovies()
    }

    func getMovieDetails(id: Int) {
        moviesNetworkService.getMovieDetails(id: id) { [weak self] result in
            switch result {
            case .success(let detailsModel):
                self?.notify(for: .detailsDidFetch(.init(responseModel: detailsModel)))
            case .failure(let error):
                self?.notify(for: .error(error))
            }
        }
    }

    func searchMovie(name: String) {
        searchWorkItem?.cancel()

        let newWorkItem = DispatchWorkItem { [weak self] in
            self?.moviesNetworkService.getMovie(name: name) { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .success(let movies):
                    let movies: [MoviesDomainModel] = name.isEmpty ? self.movies : movies.results
                        .filter { $0.posterPath != nil }
                        .map { .init(genres: self.genres, moviesResponseModel: $0)}
                    self.notify(for: .moviesDidFetch(movies))
                case .failure(let error):
                    notify(for: .error(error))
                }
            }
        }
        searchWorkItem = newWorkItem

        guard let searchWorkItem = self.searchWorkItem else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: searchWorkItem)
    }

    func reloadData() {
        currentPage = 1
        fetchMovies()
    }
}

// MARK: - ReachabilityManagerDelegate
extension MoviesManagerImpl: ReachabilityManagerDelegate {
    func connnectionError(connectionError: ReachabilityError) {
        isConnected = false
        notify(for: .error(connectionError))
    }

    func connectionRestored() {
        isConnected = true
    }
}

// MARK: - Private extenison
private extension MoviesManagerImpl {
    func notify(for event: MoviesManagerEvent) {
        for subscriber in subscribers {
            switch event {
            case .genresDidFetch:
                fetchMovies()
            case .moviesDidFetch(let movies):
                subscriber.movieManager(self, didFetch: movies)
            case .detailsDidFetch(let details):
                subscriber.movieManager(self, didFetch: details)
            case .filterDidUpdate(let filter):
                subscriber.movieManager(self, didChange: filter)
            case .error(let error):
                subscriber.movieManager(self, didFail: error)
            }
        }
    }
}
