//
//  RequestBuilderError.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

enum RequestBuilderError: Error {
    case bodyEncodingError
    case badURL
    case badURLComponents
}

extension RequestBuilderError: LocalizedError {
    var requestErrorDescription: String? {
        switch self {
        case .bodyEncodingError:
            return "Error encoding the body"
        case .badURL:
            return "Bad request URL"
        case .badURLComponents:
            return "Bad URL components"
        }
    }
}
