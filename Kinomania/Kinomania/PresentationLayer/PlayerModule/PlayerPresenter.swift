//
//  PlayerPresenter.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 03/07/2024.
//

import Foundation

protocol PlayerViewOutput { }

final class PlayerPresenter: BasePresenter {
    // MARK: - Private propertis
    private unowned let view: PlayerViewInput
    private var router: PlayerModuleRouter?
    private let videoKey: String

    // MARK: - Init
    init(view: PlayerViewInput, router: PlayerModuleRouter?, videoKey: String) {
        self.view = view
        self.router = router
        self.videoKey = videoKey
    }

    // MARK: - Life cycle
    override func onViewDidLoad() {
        view.setVideoKeyAndPlay(key: videoKey)
    }
}

// MARK: - PlayerViewOutput
extension PlayerPresenter: PlayerViewOutput {

}
