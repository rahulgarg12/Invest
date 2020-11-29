//
//  ThemesViewModel.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

import Foundation

final class ThemesViewModel {
    //MARK: - Properties
    var themes = [ThemeModel]()
    
    //MARK: - Enum
    private enum ThemeText: CaseIterable {
        case diversity
        case bitotech
        case crypto
        case run
        case clean
        case cannabis
        case power
        case foodie
        case art
        case home
        
        var title: String {
            switch self {
            case .diversity: return "Diversity & Inclusion"
            case .bitotech: return "Bold Biotech"
            case .crypto: return "Crypto Central"
            case .run: return "She runs it"
            case .clean: return "Clean & Green"
            case .cannabis: return "Cannibis-ness"
            case .power: return "Power It"
            case .foodie: return "Foodie Fun"
            case .art: return "Art & Fashion"
            case .home: return "Home is where the heart is"
            }
        }
        
        var imageName: String {
            switch self {
            case .diversity: return "house"
            case .bitotech: return "house"
            case .crypto: return "house"
            case .run: return "house"
            case .clean: return "house"
            case .cannabis: return "house"
            case .power: return "house"
            case .foodie: return "house"
            case .art: return "house"
            case .home: return "house"
            }
        }
    }
    
    //MARK: - Init
    init() {
        for element in ThemeText.allCases {
            let item = ThemeModel(imageName: element.imageName,
                                  headline: element.title)
            themes.append(item)
        }
    }
}
