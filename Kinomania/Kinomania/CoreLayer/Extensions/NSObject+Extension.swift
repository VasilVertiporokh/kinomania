//
//  NSObject+Extension.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
