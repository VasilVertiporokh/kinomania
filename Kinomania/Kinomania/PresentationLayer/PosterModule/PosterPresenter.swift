//
//  PosterPresenter.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 03/07/2024.
//

import Foundation

protocol PosterViewOutput {
    func closePosterPreview()
}

final class PosterPresenter: BasePresenter {
    // MARK: - Private properties
    private unowned let view: PosterViewInput
    private var router: PosterModuleRouter?
    private let posterUrl: URL?

    // MARK: - Init
    init(view: PosterViewInput, router: PosterModuleRouter, posterUrl: URL?) {
        self.view = view
        self.router = router
        self.posterUrl = posterUrl
    }

    // MARK: - Life cycle
    override func onViewDidLoad() {
        view.setPosterUrl(url: posterUrl)
    }
}

// MARK: - PosterPresenter
extension PosterPresenter: PosterViewOutput {
    func closePosterPreview() {
        router?.closePreview()
    }
}
