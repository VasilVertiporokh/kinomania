//
//  BasePlugin.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

struct BasePlugin {
    // MARK: - Private properties
    private let apiKey: String

    // MARK: - Init
    init(apiKey: String) {
        self.apiKey = apiKey
    }
}

// MARK: - NetworkPlugin
extension BasePlugin: NetworkPlugin {
    func modifyRequest(_ request: inout URLRequest) {
        guard var urlComponents = URLComponents(string: request.url?.absoluteString ?? "") else {
            return
        }
        let apiKey = URLQueryItem(name: "api_key", value: apiKey)
        var queryItems = urlComponents.queryItems ?? []
        queryItems.append(apiKey)
        urlComponents.queryItems = queryItems
        request.url = urlComponents.url
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
