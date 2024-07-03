//
//  Yypealias.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

typealias VoidCallback = (() -> Void)
typealias CallbackWith<T> = ((T) -> Void)
typealias DataResult<T> = ((Result<T, NetworkError>) -> Void)
