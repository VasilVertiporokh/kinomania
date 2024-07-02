//
//  NetworkServiceProvider.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

final class NetworkServiceProvider<Endpoint: EndpointBuilderProtocol>: NetworkProviderProtocol {
    // MARK: - Internal properties
    private(set) var apiInfo: ApiInfo
    private(set) var decoder: JSONDecoder
    private(set) var encoder: JSONEncoder
    private(set) var plugins: [NetworkPlugin]

    // MARK: - Private properties
    private let networkManager: NetworkManagerProtocol

    // MARK: - Init
    init(
        apiInfo: ApiInfo,
        decoder: JSONDecoder = JSONDecoder(),
        encoder: JSONEncoder = JSONEncoder(),
        networkManager: NetworkManagerProtocol,
        plugins: [NetworkPlugin] = []
    ) {
        self.apiInfo = apiInfo
        self.decoder = decoder
        self.encoder = encoder
        self.networkManager = networkManager
        self.plugins = plugins
    }

    // MARK: - Internal methods
    func performWithResponseModel<T: Decodable>(_ builder: Endpoint, response: T.Type, responseHandler: NetworkDataResponse<T>) {
        do {
            let request = try builder.createRequest(apiInfo.baseURL, encoder, plugins)
            networkManager.resumeDataTask(request) { [weak self] result in
                guard let self = self else {
                    responseHandler?(.failure(NetworkError.unexpectedError))
                    return
                }
                switch result {
                case .success(let data):
                    do {
                        let data = try self.decoder.decode(response, from: data)
                        responseHandler?(.success(data))
                    } catch {
                        responseHandler?(.failure(NetworkError.decodingError))
                    }
                case .failure(let error):
                    responseHandler?(.failure(error))
                }
            }
        } catch {
            responseHandler?(.failure(NetworkError.requestError(error as! RequestBuilderError)))
        }
    }

    func performWithProcessingResult(_ builder: Endpoint, responseHandler: NetworkVoidResponse) {
        do {
            let request = try builder.createRequest(apiInfo.baseURL, encoder, plugins)
            networkManager.resumeDataTask(request) { result in
                switch result {
                case .success:
                    responseHandler?(.success(()))
                case .failure(let error):
                    responseHandler?(.failure(error))
                }
            }

        } catch {
            responseHandler?(.failure(NetworkError.requestError(error as! RequestBuilderError)))
        }
    }

    func performWithRawData(_ builder: Endpoint, responseHandler : NetworkRawDataResponse) {
        do {
            let request = try builder.createRequest(apiInfo.baseURL, encoder, plugins)
            networkManager.resumeDataTask(request) { result in
                switch result {
                case .success(let data):
                    responseHandler?(.success(data))
                case .failure(let error):
                    responseHandler?(.failure(error))
                }
            }
        } catch {
            responseHandler?(.failure(NetworkError.requestError(error as! RequestBuilderError)))
        }
    }
}
