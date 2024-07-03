//
//  MoviesModuleConfigurator.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import UIKit

final class MoviesModuleConfigurator {
    class func createModule(router: MoviesModuleRouter) -> UIViewController {
        let viewController = MoviesViewController()
        let presenter = MoviesPresenter(view: viewController, router: router)
        viewController.output = presenter
        return viewController
    }
}
