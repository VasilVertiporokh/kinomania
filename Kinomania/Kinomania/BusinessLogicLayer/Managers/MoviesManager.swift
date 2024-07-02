//
//  MoviesManager.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import Foundation
import Factory

enum MoviesManagerEvent {
    case genresDidFetch
    case moviesDidFetch([MoviesDomainModel])
    case detailsDidFetch(MoviewDetailsDomainModel)
    case filterDidUpdate(Filter)
    case error(Error)
}

protocol MovieManagerObserver: AnyObject {
    func movieManager(_ movieManager: MoviesManager, _ movies: [MoviesDomainModel])
    func movieManager(_ movieManager: MoviesManager, _ filter: Filter)
    func movieManager(_ movieManager: MoviesManager, _ details: MoviewDetailsDomainModel)
    func movieManager(_ movieManager: MoviesManager, didFail error: Error)
}

extension MovieManagerObserver {
    func movieManager(_ movieManager: MoviesManager, _ movies: [MoviesDomainModel]) { }
    func movieManager(_ movieManager: MoviesManager, _ filter: Filter) { }
    func movieManager(_ movieManager: MoviesManager, _ details: MoviewDetailsDomainModel) { }
}

protocol MoviesManager: AnyObject {
    var movies: [MoviesDomainModel] { get }
    var currentPage: Int { get }
    var currentFilter: Filter { get }

    func subscribe(_ subscriber: MovieManagerObserver)
    func unsubscribe(_ subscriber: MovieManagerObserver)
    func fetchInitialMovies()
    func fetchMovies(filter: Filter)
    func getMovieDetails(id: Int)
    func searchMovie(name: String)
}

final class MoviesManagerImpl {
    // MARK: - Dependecy
    @Injected (\.moviesNetworkService) private var moviesNetworkService

    // MARK: - Internal properties
    private(set) var movies: [MoviesDomainModel] = []
    private(set) var currentPage: Int = 1
    private(set) var currentFilter: Filter = .popularity {
        didSet {
            currentPage = 1
        }
    }

    // MARK: - Private properties
    private var subscribers: [MovieManagerObserver] = []
    private var genres: [GenresResponseModel] = []
    private var searchWorkItem: DispatchWorkItem?
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
        moviesNetworkService.getGenres { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let genresList):
                self.genres = genresList.genres
                self.fetchMovies(filter: self.currentFilter)
            case .failure(let error):
                self.notify(for: .error(error))
            }
        }
    }

    func fetchMovies(filter: Filter) {
        if currentFilter != filter {
            currentFilter = filter
            notify(for: .filterDidUpdate(filter))
        }
        moviesNetworkService.getMovies(pageNumber: "\(currentPage)", filter: filter) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let movies):
                self.movies = movies.results.map { .init(genres: self.genres, moviesResponseModel: $0) }
                self.notify(for: .moviesDidFetch(self.movies))
                self.currentPage += 1
            case .failure(let error):
                self.notify(for: .error(error))
            }
        }
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

        searchWorkItem = DispatchWorkItem { [weak self] in
            self?.moviesNetworkService.getMovie(name: name) { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .success(let movies):
                    let movies: [MoviesDomainModel] = name.isEmpty ? self.movies : movies.results
                        .map { .init(genres: self.genres, moviesResponseModel: $0)}
                    self.notify(for: .moviesDidFetch(movies))
                case .failure(let error):
                    notify(for: .error(error))
                }
            }

            guard let searchWorkItem = self?.searchWorkItem else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: searchWorkItem)
        }
    }
}

// MARK: - Private extenison
private extension MoviesManagerImpl {
    func notify(for event: MoviesManagerEvent) {
        for subscriber in subscribers {
            switch event {
            case .genresDidFetch:
                fetchMovies(filter: .popularity)
            case .moviesDidFetch(let movies):
                subscriber.movieManager(self, movies)
            case .detailsDidFetch(let details):
                subscriber.movieManager(self, details)
            case .filterDidUpdate(let filter):
                subscriber.movieManager(self, filter)
            case .error(let error):
                subscriber.movieManager(self, didFail: error)
            }
        }
    }
}
