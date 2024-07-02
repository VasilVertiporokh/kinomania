//
//  BasePresenter.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import Foundation

protocol BasePresenterProtocol: AnyObject {
    func onViewDidLoad()
    func onViewWillAppear()
    func onViewWillDisappear()
    func onViewDidAppear()
    func onViewDidDisappear()
}

class BasePresenter: BasePresenterProtocol {
    // MARK: - Life cycle
    func onViewDidLoad() { }

    func onViewWillAppear() { }

    func onViewWillDisappear() { }

    func onViewDidAppear() { }

    func onViewDidDisappear() { }

    deinit {  debugPrint("Deinit of \(String(describing: self))") }
}
