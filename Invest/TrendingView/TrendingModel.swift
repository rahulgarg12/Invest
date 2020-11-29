//
//  TrendingModel.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

import Foundation

typealias TrendingQuote = [String: Double]

struct TrendingModel: Codable {
    let base: String?
    let quote: TrendingQuote?
}
