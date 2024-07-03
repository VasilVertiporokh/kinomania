//
//  SplashViewController.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

protocol SplashViewInput: BaseViewProtocol {
    func runSplashAnimation()
}

final class SplashViewController: BaseViewController {
    // MARK: - Content view
    private let contentView = SplashView()
    
    // MARK: - Internal properires
    var presenter: SplashPresenter!

    // MARK: - Life cycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
        initialSetup()
    }
}

// MARK: - SplashViewInput
extension SplashViewController: SplashViewInput {
    func runSplashAnimation() {
        contentView.runAnimation()
    }
}

// MARK: - SplashViewDelegate
extension SplashViewController: SplashViewDelegate {
    func animationDidFinish() {
        presenter?.showFeed()
    }
}

// MARK: - Private extenison
private extension SplashViewController {
    func initialSetup() {
        contentView.delegate = self
    }
}
