//
//  NetworkManagerImpl.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

final class NetworkManagerImpl: NetworkManagerProtocol {
    // MARK: - Private properties
    private let urlSession: URLSession

    // MARK: - Init
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
}

// MARK: - Internal extension
extension NetworkManagerImpl {
    func resumeDataTask(_ requset: URLRequest, resultHandler: NetworkRawDataResponse) {
        urlSession.dataTask(with: requset) { [weak self] data, response, error in
            guard let self = self else {
                return
            }

            if let error = error {
                let networkError = self.convertError(error: error as NSError)
                DispatchQueue.main.async {
                    resultHandler?(.failure(networkError))
                }
                return
            }

            NetworkLogger.log(responseData: data, response: response)

            handleError(response: response, data: data) { result in
                switch result {
                case .success:
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        resultHandler?(.success(data))
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        resultHandler?(.failure(error))
                    }
                }
            }
        }
        .resume()
    }
}

// MARK: - Private extension
private extension NetworkManagerImpl {
    func handleError(response: URLResponse?, data: Data?, errorHandler: (Result<Void, NetworkError>) -> Void) {
        guard let httpResponse = response as? HTTPURLResponse else {
            return
        }

        switch httpResponse.statusCode {
        case 200...399:
            errorHandler(.success(()))
        case 400...499:
            errorHandler(.failure(NetworkError.clientError(data)))
        case 500...599:
            errorHandler(.failure(NetworkError.serverError(data)))
        default:
            errorHandler(.failure(NetworkError.unexpectedError))
        }
    }

    func convertError(error: NSError) -> NetworkError {
        switch error.code {
        case NSURLErrorBadURL:
            return .badURLError
        case NSURLErrorTimedOut:
            return .timedOutError
        case NSURLErrorCannotFindHost:
            return .hostError
        case NSURLErrorCannotConnectToHost:
            return .hostError
        case NSURLErrorHTTPTooManyRedirects:
            return .tooManyRedirectsError
        case NSURLErrorResourceUnavailable:
            return .resourceUnavailable
        default: return .unexpectedError
        }
    }
}
