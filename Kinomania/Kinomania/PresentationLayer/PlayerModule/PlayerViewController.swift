//
//  PlayerViewController.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 03/07/2024.
//

import UIKit

protocol PlayerViewInput: BaseViewProtocol {
    func setVideoKeyAndPlay(key: String)
}

final class PlayerViewController: BaseViewController {
    // MARK: - Content view
    private let contentView = PlayerView()

    // MARK: - Internal properires
    var output: PlayerViewOutput!

    // MARK: - Life cycle
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.onViewDidLoad()
        initialSetup()
    }
}

// MARK: - PlayerViewInput
extension PlayerViewController: PlayerViewInput {
    func setVideoKeyAndPlay(key: String) {
        contentView.setVideoKey(key: key)
    }
}

// MARK: - PlayerViewDelegate
extension PlayerViewController: PlayerViewDelegate {
    func playerError(_ error: Error?) {
        onError(error)
    }
}

// MARK: - Private extenison
private extension PlayerViewController {
    func initialSetup() {
        contentView.delegate = self
    }
}
