//
//  EndpointBuilderProtocol.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

protocol EndpointBuilderProtocol {
    var baseURL: URL? { get }
    var path: String { get }
    var query: [String: String]? { get }
    var headerFields: [String: String] { get }
    var body: RequestBody? { get }
    var method: HTTPMethod { get }
}

extension EndpointBuilderProtocol {
    var headerFields: [String: String] {
        return [:]
    }
}

// MARK: - Internal extension
extension EndpointBuilderProtocol {
    var baseURL: URL? { nil }
    var query: [String: String]? { nil }
    var body: RequestBody? { nil }

    func createRequest(_ baseUrl: URL, _ encoder: JSONEncoder, _ plugins: [NetworkPlugin]) throws -> URLRequest {
        var request: URLRequest
        do {
            request = .init(url: try buildUrl(self.baseURL ?? baseUrl))
        } catch {
            throw error
        }
        request.httpMethod = method.rawValue
        headerFields.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        plugins.forEach { $0.modifyRequest(&request) }

        guard let body = body else {
            NetworkLogger.log(request)
            return request
        }

        switch body {
        case .rawData(let data):
            request.httpBody = data

        case .encodable(let encodable):
            guard let data = try? encoder.encode(encodable) else {
                throw RequestBuilderError.bodyEncodingError
            }
            request.httpBody = data
        }
        NetworkLogger.log(request)
        return request
    }

}

// MARK: - Private extension
private extension EndpointBuilderProtocol {
    func buildUrl(_ baseURL: URL) throws -> URL {
        let url = baseURL.appendingPathComponent(path)
        guard let query = query else {
            return url
        }

        guard var components = URLComponents(string: url.absoluteString) else {
            throw RequestBuilderError.badURL
        }
        components.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = components.url else {
            throw RequestBuilderError.badURLComponents
        }
        return url
    }
}
