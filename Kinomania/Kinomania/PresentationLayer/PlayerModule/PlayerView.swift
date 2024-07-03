//
//  PlayerView.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 03/07/2024.
//

import UIKit
import YouTubeiOSPlayerHelper

protocol PlayerViewDelegate: AnyObject {
    func playerError(_ error: Error?)
}

final class PlayerView: UIView {
    // MARK: - Subviews
    private var playerView = YTPlayerView()
    
    // MARK: - Internal properties
    weak var delegate: PlayerViewDelegate?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - YTPlayerViewDelegate
extension PlayerView: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    
    func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        delegate?.playerError(error as? Error)
    }
}

// MARK: - Internal extension
extension PlayerView {
    func setVideoKey(key: String) {
        playerView.load(withVideoId: key)
    }
}

// MARK: - Private extenison
private extension PlayerView {
    func initialSetup() {
        setupLayout()
        setupUI()
    }
    
    func setupLayout() {
        addSubview(playerView, withEdgeInsets: .zero)
    }
    
    func setupUI() {
        backgroundColor = .black
        playerView.delegate = self
    }
}
