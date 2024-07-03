//
//  SplashPresenter.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

protocol SplashViewOutput {
    func showFeed()
}

final class SplashPresenter: BasePresenter {
    // MARK: - Private properties
    private unowned let view: SplashViewInput
    private var router: SplashModuleRouter?

    // MARK: - Init
    init(view: SplashViewInput, router: SplashModuleRouter) {
        self.view = view
        self.router = router
    }

    // MARK: - Life cycle
    override func onViewDidLoad() {
        view.runSplashAnimation()
    }
}

// MARK: - SplashViewOutput
extension SplashPresenter: SplashViewOutput {
    func showFeed() {
        router?.showFeed()
    }
}
