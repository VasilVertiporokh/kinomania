//
//  SplashPresenter.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation
import Factory

protocol SplashViewOutput: BasePresenterProtocol {
    func showFeed()
}

final class SplashPresenter {
    // MARK: - Private properties
    private unowned let view: SplashViewInput
    private var router: SplashModuleRouter?

    // MARK: - Dependency

    // MARK: - Init
    init(view: SplashViewInput, router: SplashModuleRouter) {
        self.view = view
        self.router = router
    }

    // MARK: - Deinit
    deinit {  debugPrint("Deinit of \(String(describing: self))") }

    // MARK: - Life cycle
    func onViewDidLoad() {
        view.runSplashAnimation()
    }
}

// MARK: - SplashViewOutput
extension SplashPresenter: SplashViewOutput {
    func showFeed() {
        router?.showFeed()
    }
}
