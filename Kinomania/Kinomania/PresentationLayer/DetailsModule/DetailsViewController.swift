//
//  DetailsViewController.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 03/07/2024.
//

import UIKit

protocol DetailsViewInput: BaseViewProtocol {
    func setDetails(model: MoviewDetailsDomainModel)
}

final class DetailsViewController: BaseViewController {
    // MARK: - Content view
    private let contentView = DetailsView()

    // MARK: - Internal properires
    var presenter: DetailsPresenter!

    // MARK: - Life cycle
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
        initialSetup()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.onViewDidDisappear()
    }
}

// MARK: - DetailsViewInput
extension DetailsViewController: DetailsViewInput {
    func setDetails(model: MoviewDetailsDomainModel) {
        title = model.title
        contentView.setDetails(model: .init(domainModel: model))
    }
}

// MARK: - DetailsViewDelegate
extension DetailsViewController: DetailsViewDelegate {
    func posterDidTap() {
        presenter?.showPoster()
    }
    
    func playButtonDidTap() {
        presenter?.showPlayer()
    }
}

// MARK: - Private extenison
private extension DetailsViewController {
    func initialSetup() {
        contentView.delegate = self
    }
}
