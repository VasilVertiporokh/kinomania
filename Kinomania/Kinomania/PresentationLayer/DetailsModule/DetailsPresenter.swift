//
//  DetailsPresenter.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 03/07/2024.
//

import Foundation
import Factory

protocol DetailsViewOutput: BasePresenterProtocol {
    func showPoster()
    func showPlayer()
}

final class DetailsPresenter: BasePresenter {
    // MARK: - Dependency
    @Injected (\.moviesManager) private var moviesManager
    
    // MARK: - Private properties
    private unowned let view: DetailsViewInput
    private var router: DetailsModuleRouter?
    private let movieId: Int
    
    private var posterUrl: URL?
    private var videoKey: String?
    
    // MARK: - Init
    init(view: DetailsViewInput, router: DetailsModuleRouter, movieId: Int) {
        self.view = view
        self.router = router
        self.movieId = movieId
    }
    
    // MARK: - Life cycle
    override func onViewDidLoad() {
        view.startLoading()
        moviesManager.subscribe(self)
        moviesManager.getMovieDetails(id: movieId)
    }
    
    override func onViewDidDisappear() {
        moviesManager.unsubscribe(self)
    }
}

// MARK: - SplashViewOutput
extension DetailsPresenter: DetailsViewOutput {
    func showPoster() {
        router?.showPoster(imageUrl: posterUrl)
    }
    
    func showPlayer() {
        guard let videoKey = videoKey else { return }
        router?.showPlayer(videoKey: videoKey)
    }
}

// MARK: - MovieManagerObserver
extension DetailsPresenter: MovieManagerObserver {
    func movieManager(_ movieManager: MoviesManager, didFetch details: MoviewDetailsDomainModel) {
        view.stopLoading()
        posterUrl = details.posterUrl
        videoKey = details.videoKey
        view.setDetails(model: details)
    }
    
    func movieManager(_ movieManager: MoviesManager, didFail error: Error) {
        view.stopLoading()
        view.onError(errorMessage: error.localizedDescription)
    }
}
