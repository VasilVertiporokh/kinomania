//
//  BaseViewProtocol.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

protocol BaseViewProtocol {
    func startLoading()
    func stopLoading()

    func onError(_ error: Error?)
    func onError(errorMessage: String?)
}
