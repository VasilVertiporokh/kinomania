//
//  PosterView .swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 03/07/2024.
//

import UIKit
import Kingfisher

protocol PosterViewDelegate: AnyObject {
    func closeButtonDidTap()
}

final class PosterView: UIView {
    // MARK: - Subviews
    private let scrollView = KScrollView()
    private let posterImageView = UIImageView()
    private let closeButton = UIButton(type: .system)

    // MARK: - Internal properties
    weak var delegate: PosterViewDelegate?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = bounds
        posterImageView.frame = scrollView.bounds
    }
}

// MARK: - Internal extension
extension PosterView {
    func setPosterUrl(url: URL?) {
        posterImageView.kf.setImage(with: url)
    }
}

// MARK: - Private extenison
private extension PosterView {
    func initialSetup() {
        setupLayout()
        setupUI()
    }

    func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(posterImageView)
        addSubview(closeButton, constraints: [
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor)
        ])
    }

    func setupUI() {
        backgroundColor = .black
        posterImageView.contentMode = .scaleAspectFit
        closeButton.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        closeButton.setImage(Assets.close.image, for: .normal)

        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delaysContentTouches = false
        scrollView.zoomScale = 1
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        scrollView.delegate = self
    }

    @objc func closeButtonDidTap() {
        delegate?.closeButtonDidTap()
    }
}

// MARK: - UIScrollViewDelegate
extension PosterView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        posterImageView
    }
}
