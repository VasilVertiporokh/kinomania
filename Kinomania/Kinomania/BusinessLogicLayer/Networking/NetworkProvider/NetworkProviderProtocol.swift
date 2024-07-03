//
//  NetworkProviderProtocol.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

protocol ApiInfo {
    var baseURL: URL { get }
}

// MARK: - CombineNetworkServiceProtocol
protocol NetworkProviderProtocol {
    // MARK: - Associatedtype
    associatedtype Endpoint: EndpointBuilderProtocol

    // MARK: - Properties
    var decoder: JSONDecoder { get }
    var encoder: JSONEncoder { get }

    // MARK: - Methods
    func performWithResponseModel<T: Decodable>(_ builder: Endpoint, response: T.Type ,responseHandler: NetworkDataResponse<T>)
    func performWithProcessingResult(_ builder: Endpoint, responseHandler: NetworkVoidResponse)
    func performWithRawData(_ builder: Endpoint, responseHandler: NetworkRawDataResponse)
}
