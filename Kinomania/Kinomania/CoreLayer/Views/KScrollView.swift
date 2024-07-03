//
//  BaseScrollView.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import UIKit

final class KScrollView: UIScrollView {
    // MARK: - Internal propeties
    let axis: NSLayoutConstraint.Axis
    let contentView = UIView()

    // MARK: - Init
    init(axis: NSLayoutConstraint.Axis = .vertical) {
        self.axis = axis
        super.init(frame: .zero)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private extenison
private extension KScrollView {
    func initialSetup() {
        if axis == .vertical {
            addSubview(contentView, constraints: [
                contentView.topAnchor.constraint(equalTo: topAnchor),
                contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
                contentView.widthAnchor.constraint(equalTo: widthAnchor),
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        } else {
            addSubview(contentView, constraints: [
                contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
                contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
                contentView.heightAnchor.constraint(equalTo: heightAnchor),
                contentView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
    }
}
