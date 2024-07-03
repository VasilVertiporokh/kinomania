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
    var output: DetailsViewOutput!

    // MARK: - Life cycle
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.onViewDidLoad()
        initialSetup()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        output.onViewDidDisappear()
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
        output?.showPoster()
    }
    
    func playButtonDidTap() {
        output?.showPlayer()
    }
}

// MARK: - Private extenison
private extension DetailsViewController {
    func initialSetup() {
        contentView.delegate = self
    }
}
