//
//  SplashView.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import UIKit
import Lottie

protocol SplashViewDelegate: AnyObject {
    func animationDidFinish()
}

final class SplashView: UIView {
    // MARK: - Subviews
    private let animationView = LottieAnimationView(name: "splashAnimation")

    // MARK: - Intrnal properties
    weak var delegate: SplashViewDelegate?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Internal extension
extension SplashView {
    func runAnimation() {
        animationView.loopMode = .playOnce
        animationView.play { [unowned self] _ in
            delegate?.animationDidFinish()
            animationView.stop()
        }
    }
}

// MARK: - Private extenison
private extension SplashView {
    func initialSetup() {
        setupLayout()
        setupUI()
    }

    func setupLayout() {
        addSubview(animationView, constraints: [
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 200),
            animationView.widthAnchor.constraint(equalTo: animationView.heightAnchor)
        ])
    }

    func setupUI() {
        backgroundColor = .white
    }
}

