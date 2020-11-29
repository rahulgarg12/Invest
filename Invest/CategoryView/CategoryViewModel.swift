//
//  CategoryViewModel.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

import Foundation

final class CategoryViewModel {
    //MARK: - Properties
    var categories = [CategoryModel]()
    
    //MARK: - Enum
    private enum CategoryText: CaseIterable {
        case stocks
        case etf
        case crypto
        
        var title: String {
            switch self {
            case .stocks: return "Stocks"
            case .etf: return "ETFs"
            case .crypto: return "Crypto"
            }
        }
        
        var imageName: String {
            switch self {
            case .stocks: return "bitcoin"
            case .etf: return "bitcoin"
            case .crypto: return "bitcoin"
            }
        }
        
        var backgroundHex: String {
            switch self {
            case .stocks: return "a4a5f7"
            case .etf: return "4b51c5"
            case .crypto: return "f6d55c"
            }
        }
    }
    
    //MARK: - Init
    init() {
        for element in CategoryText.allCases {
            let item = CategoryModel(imageName: element.imageName,
                                     headline: element.title,
                                     backgroundHex: element.backgroundHex)
            categories.append(item)
        }
    }
}
