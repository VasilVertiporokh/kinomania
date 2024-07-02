//
//  NetworkManagerProtocol.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

typealias NetworkRawDataResponse = ((Result<Data, NetworkError>) -> Void)?
typealias NetworkVoidResponse = ((Result<Void, NetworkError>) -> Void)?
typealias NetworkDataResponse<T: Decodable> = ((Result<T, NetworkError>) -> Void)?

protocol NetworkManagerProtocol {
    func resumeDataTask(_ requset: URLRequest, resultHandler: NetworkRawDataResponse)
}
