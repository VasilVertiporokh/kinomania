//
//  MoviesModuleRouter.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import Foundation

protocol MoviesModuleRouter {
    func showMovie(movieId: Int)
    func showFilers(filter: Filter, complitionHandler: ((Filter) -> Void)?)
}
