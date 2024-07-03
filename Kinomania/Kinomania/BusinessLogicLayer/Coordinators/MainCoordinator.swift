//
//  MainCoordinator.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import UIKit

final class MainCoordinator: Coordinator {
    // MARK: - Internal properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let module = SplashModuleConfigurator.createModule(router: self)
        setRoot(module)
    }
}

// MARK: - SplashModuleRouter
extension MainCoordinator: SplashModuleRouter {
    func showFeed() {
        let module = MoviesModuleConfigurator.createModule(router: self)
        setRoot(module)
    }
}

// MARK: - MoviesModuleRouter
extension MainCoordinator: MoviesModuleRouter {
    func showMovie(movieId: Int) {
        let module = DetailsModuleConfigurator.createModule(router: self, movieId: movieId)
        push(module)
    }

    func showFilers(filter: Filter, complitionHandler: ((Filter) -> Void)?) {
        let actionSheet = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet)

        Filter.allCases.forEach { item in
            let action = UIAlertAction(
                title: item.filterName,
                style: .default) { _ in
                    complitionHandler?(item)
                }
            let isChecked = (filter == item)
            action.setValue(isChecked, forKey: "checked")
            actionSheet.addAction(action)
        }

        let cancelAction = UIAlertAction(
            title: Localization.General.cancel,
            style: .cancel
        )
        actionSheet.addAction(cancelAction)
        present(actionSheet)
    }
}

// MARK: - DetailsModuleRouter
extension MainCoordinator: DetailsModuleRouter {
    func showPoster(imageUrl: URL?) {
        let module = PosterModuleConfigurator.createModule(router: self, posterUrl: imageUrl)
        presentWithStyle(module, style: .overFullScreen)
    }
    
    func showPlayer(videoKey: String) {
        let module = PlayerModuleConfigurator.createModule(router: self, videoKey: videoKey)
        present(module)
    }
}

// MARK: - PlayerModuleRouter
extension MainCoordinator: PlayerModuleRouter { }

// MARK: -
extension MainCoordinator: PosterModuleRouter { 
    func closePreview() {
        dismissPresentedController()
    }
}
