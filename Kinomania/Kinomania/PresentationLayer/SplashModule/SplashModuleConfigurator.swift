//
//  SplashModuleConfigurator.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import UIKit

final class SplashModuleConfigurator {
    class func createModule(router: SplashModuleRouter) -> UIViewController {
        let viewController = SplashViewController()
        let presenter = SplashPresenter(view: viewController, router: router)
        viewController.output = presenter
        return viewController
    }
}
