//
//  Coordinator.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

extension Coordinator {
    func addChild(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
    }

    func removeChild(coordinator: Coordinator) {
        self.childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }

    func setRoot(_ viewController: UIViewController, animated: Bool = true) {
        self.navigationController.setViewControllers([viewController], animated: animated)
    }

    func setRoot(_ viewControllers: [UIViewController], animated: Bool = true) {
        self.navigationController.setViewControllers(viewControllers, animated: animated)
    }

    func push(_ viewController: UIViewController, animated: Bool = true) {
        self.navigationController.pushViewController(viewController, animated: animated)
    }

    func pop(animated: Bool = true) {
        self.navigationController.popViewController(animated: animated)
    }

    func dismissPresentedController(completion:  (() -> Void)? = nil) {
        self.navigationController.presentedViewController?.dismiss(animated: true, completion: completion)
    }
    func presentWithStyle(_ viewController: UIViewController, animated: Bool = true, style: UIModalPresentationStyle) {
        viewController.modalPresentationStyle = style
        self.navigationController.present(viewController, animated: animated)
    }

    func present(_ viewController: UIViewController, animated: Bool = true) {
        self.navigationController.present(viewController, animated: true)
    }
}
