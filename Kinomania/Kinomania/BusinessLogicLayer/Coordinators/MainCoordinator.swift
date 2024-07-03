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
        let vc = SplashModuleConfigurator.createModule(router: self)
        setRoot(vc)
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
        print(movieId)
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
