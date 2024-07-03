//
//  NetworkError.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

struct ErrorResponseModel: Decodable {
    var statusMessage: String?
    var statusCode: Int

    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}

// MARK: - NetworkErrorEnum
enum NetworkError: Error {
    case clientError(Data?)
    case serverError(Data?)
    case decodingError
    case unexpectedError
    case badURLError
    case timedOutError
    case hostError
    case tooManyRedirectsError
    case resourceUnavailable
    case tokenError
    case requestError(RequestBuilderError)
}

// MARK: - LocalizedError
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .clientError(let data), .serverError(let data):
            let defaultMessege = "An error occurred on the client side. Please try again later."
            guard let data = data,
                  let model = try? JSONDecoder().decode(ErrorResponseModel.self, from: data) else {
                return defaultMessege
            }
            return model.statusMessage
        case .decodingError:
            return "We were unable to identify the data that came from the server. Please try again later."
        case .unexpectedError:
            return "For unknown reasons, something went wrong. Please try again later."
        case .badURLError:
            return "Bad URL Error. Please try again later."
        case .timedOutError:
            return "Timed Out Error. Please check your internet connection."
        case .hostError:
            return "Host Error. Please try again later."
        case .tooManyRedirectsError:
            return "Too Many Redirects. Please try again later."
        case .resourceUnavailable:
            return "Resource Unavailable. Please try again later."
        case .tokenError:
            return "Token error"
        case .requestError(let error):
            return error.requestErrorDescription
        }
    }
}
