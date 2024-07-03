//
//  PosterModuleConfigurator.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 03/07/2024.
//

import UIKit

final class PosterModuleConfigurator {
    class func createModule(router: PosterModuleRouter, posterUrl: URL?) -> UIViewController {
        let viewController = PosterViewController()
        let presenter = PosterPresenter(view: viewController, router: router, posterUrl: posterUrl)
        viewController.presenter = presenter
        return viewController
    }
}

