//
//  Double+Extension.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import Foundation

extension Double {
    var roundToPlaces: Self { (self * 100).rounded() / 100 }
}
