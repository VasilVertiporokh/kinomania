//
//  RequestBody.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

// MARK: - RequestBody
enum RequestBody {
    case rawData(Data)
    case encodable(Encodable)
}
