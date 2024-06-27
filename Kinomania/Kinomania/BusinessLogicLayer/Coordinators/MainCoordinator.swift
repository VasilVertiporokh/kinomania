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
        let module = UIViewController()
        setRoot(module)
    }
}
