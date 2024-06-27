//
//  BasePresenterProtocol.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

protocol BasePresenterProtocol: AnyObject {
    func onViewDidLoad()
    func onViewWillAppear()
    func onViewWillDisappear()
    func onViewDidAppear()
    func onViewDidDisappear()
}

extension BasePresenterProtocol {
    func onViewDidLoad() {}
    func onViewWillAppear() {}
    func onViewDidAppear() {}
    func onViewWillDisappear() {}
    func onViewDidDisappear() {}
}
