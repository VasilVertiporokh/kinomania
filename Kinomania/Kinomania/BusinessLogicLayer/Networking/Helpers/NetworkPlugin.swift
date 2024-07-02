//
//  NetworkPlugin.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

protocol NetworkPlugin {
    func modifyRequest(_ request: inout URLRequest)
}

