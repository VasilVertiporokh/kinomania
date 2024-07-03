//
//  AppCoordinator.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import UIKit

final class AppCoordinator: Coordinator {
    // MARK: - Internal properties
    var window: UIWindow
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    // MARK: - Init
    init(window: UIWindow) {
        self.navigationController = UINavigationController()
        self.window = window
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func start() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.start()
    }
}
