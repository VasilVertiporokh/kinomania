//
//  NetworkLogger.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

struct NetworkLogger {
    private static let newLine = "\n"
    private static let divider = "---------------------------"

    static func log(_ request: URLRequest) {
        let method = "--method " + "\(request.httpMethod ?? HTTPMethod.get.rawValue) \(newLine)"
        let url: String = "--url " + "\'\(request.url?.absoluteString ?? "")\' \(newLine)"

        var toPrint = newLine + "REQUEST" + newLine + divider + newLine
        var header = ""
        var data: String = ""

        if let httpHeaders = request.allHTTPHeaderFields,
           !httpHeaders.keys.isEmpty {

            for (key,value) in httpHeaders {
                header += "--header " + "\'\(key): \(value)\' \(newLine)"
            }
        }

        if let bodyData = request.httpBody {
            let bodyBytes = ByteCountFormatter().string(
                fromByteCount: Int64(bodyData.count)
            )

            let bodyString = bodyData.prettyPrintedJSONString ?? bodyBytes
            data = "--data '\(bodyString)'"
        }

        toPrint += method + url + header + data + divider + newLine
        print(toPrint)
    }

    static func log(responseData: Data?, response:  URLResponse?) {
        let url: String = "--url " + "\'\(response?.url?.absoluteString ?? "")\' \(newLine)"

        var toPrint = newLine + "RESPONSE" + newLine + divider + newLine
        var header: String = ""
        var statusCode: String = ""
        var data: String = "--data "

        if let response = response as? HTTPURLResponse {
            statusCode = "--status code " + "\(response.statusCode)" + newLine
            let httpHeaders = response.allHeaderFields

            if !httpHeaders.keys.isEmpty {
                for (key,value) in httpHeaders {
                    header += "--header " + "\'\(key): \(value)\' \(newLine)"
                }
            }
        }

        let bodyBytes = ByteCountFormatter().string(
            fromByteCount: Int64(data.count)
        )

        data += responseData?.prettyPrintedJSONString ?? bodyBytes

        toPrint += url + statusCode + header + data + newLine + divider + newLine
        print(toPrint)
    }
}

// MARK: - Data + Print
private extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString as String
    }
}
