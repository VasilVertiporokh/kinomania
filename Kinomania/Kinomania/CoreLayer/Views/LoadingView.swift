//
//  LoadingView.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import UIKit
import Lottie

final class LoadingView: UIView {
    // MARK: - Internal properties
    private(set) static var tagValue: Int = 1234123
    var isLoading: Bool = false {
        didSet { isLoading ? start() : stop() }
    }

    // MARK: - Private properties
    private let indicator = LottieAnimationView(name: "loader")

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private extenison
private extension LoadingView {
    func initialSetup() {
        tag = LoadingView.tagValue
        backgroundColor = UIColor.black.withAlphaComponent(0.2)
        indicator.contentMode = .scaleAspectFit
        indicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 100).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    func start() {
        indicator.loopMode = .loop
        indicator.animationSpeed = 0.5
        indicator.play()
    }

    func stop() {
        indicator.stop()
    }
}
