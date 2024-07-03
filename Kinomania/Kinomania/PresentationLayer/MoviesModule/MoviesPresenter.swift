//
//  MoviesPresenter.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import Foundation
import Factory

protocol MoviesViewOutput: BasePresenterProtocol {
    var filterType: Filter { get }
    func getNextPage()
    func showFilters()
    func search(text: String)
    func showMovie(movieId: Int)
}

final class MoviesPresenter: BasePresenter {
    // MARK: - Dependency
    @Injected (\.moviesManager) private var moviesManager

    // MARK: - Internal properies
    var filterType: Filter { moviesManager.currentFilter }

    // MARK: - Private properties
    private unowned let view: MoviesViewInput
    private var router: MoviesModuleRouter?

    // MARK: - Init
    init(view: MoviesViewInput, router: MoviesModuleRouter) {
        self.view = view
        self.router = router
    }

    // MARK: - Life cycle
    override func onViewDidLoad() {
        view.startLoading()
        view.setTitle(title: moviesManager.currentFilter.filterName)
        moviesManager.subscribe(self)
        moviesManager.fetchInitialMovies()
    }
}

// MARK: - MoviesViewOutput
extension MoviesPresenter: MoviesViewOutput {
    func getNextPage() {
        guard moviesManager.totalPages >= moviesManager.currentPage else { return }
        moviesManager.fetchMovies()
    }

    func showFilters() {
        router?.showFilers(filter: moviesManager.currentFilter) { [weak self] filter in
            self?.view.startLoading()
            self?.view.setInitialDataSource(model: [])
            self?.moviesManager.setFilter(filter: filter)
        }
    }

    func search(text: String) {
        moviesManager.searchMovie(name: text)
    }

    func showMovie(movieId: Int) {
        router?.showMovie(movieId: movieId)
    }
}

// MARK: - MovieManagerObserver
extension MoviesPresenter: MovieManagerObserver {
    func movieManager(_ movieManager: MoviesManager, didFetch movies: [MoviesDomainModel]) {
        view.setInitialDataSource(model: movies)
        view.stopLoading()
    }

    func movieManager(_ movieManager: MoviesManager, didFail error: Error) {
        view.stopLoading()
        view.onError(errorMessage: error.localizedDescription)
    }

    func movieManager(_ movieManager: MoviesManager, didChange filter: Filter) {
        view.setTitle(title: filter.filterName)
    }
}
