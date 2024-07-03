//
//  DetailsModuleConfigurator.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 03/07/2024.
//

import UIKit

final class DetailsModuleConfigurator {
    class func createModule(router: DetailsModuleRouter, movieId: Int) -> UIViewController {
        let viewController = DetailsViewController()
        let presenter = DetailsPresenter(view: viewController, router: router, movieId: movieId)
        viewController.presenter = presenter
        return viewController
    }
}

