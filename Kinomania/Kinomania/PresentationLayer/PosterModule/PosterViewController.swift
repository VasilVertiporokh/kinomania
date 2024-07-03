//
//  PosterViewController.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 03/07/2024.
//

import UIKit

protocol PosterViewInput: BaseViewProtocol {
    func setPosterUrl(url: URL?)
}

final class PosterViewController: BaseViewController {
    private let contentView = PosterView()

    // MARK: - Internal properires
    var presenter: PosterPresenter!

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

// MARK: - PosterViewOutput
extension PosterViewController: PosterViewInput {
    func setPosterUrl(url: URL?) {
        contentView.setPosterUrl(url: url)
    }
}

// MARK: - PosterViewDelegate
extension PosterViewController: PosterViewDelegate {
    func closeButtonDidTap() {
        presenter.closePosterPreview()
    }
}

// MARK: - Private extenison
private extension PosterViewController {
    func initialSetup() {
        contentView.delegate = self
    }
}
