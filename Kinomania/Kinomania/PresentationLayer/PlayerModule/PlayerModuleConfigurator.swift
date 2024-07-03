//
//  PlayerModuleConfigurator.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 03/07/2024.
//

import UIKit

final class PlayerModuleConfigurator {
    class func createModule(router: PlayerModuleRouter, videoKey: String) -> UIViewController {
        let viewController = PlayerViewController()
        let presenter = PlayerPresenter(view: viewController, router: router, videoKey: videoKey)
        viewController.output = presenter
        return viewController
    }
}
