//
//  Double+Extension.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
