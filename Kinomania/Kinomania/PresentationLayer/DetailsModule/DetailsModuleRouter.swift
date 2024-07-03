//
//  DetailsModuleRouter.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 03/07/2024.
//

import Foundation

protocol DetailsModuleRouter {
    func showPoster(imageUrl: URL?)
    func showPlayer(videoKey: String)
}
