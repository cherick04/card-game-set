//
//  Feature.swift
//  Set
//
//  Created by Erick Chacon on 9/20/22.
//

import Foundation

struct Feature {
    let number: FeatureNumber
    let color: FeatureColor
    let symbol: FeatureSymbol
    let shade: FeatureShade
}

extension Feature {

    /// Returns an array of `Feature` that contains all 81 cards
    static func allCards() -> [Feature] {
        var features: [Feature] = []
        for number in FeatureNumber.allCases {
            for color in FeatureColor.allCases {
                for symbol in FeatureSymbol.allCases {
                    for shade in FeatureShade.allCases {
                        let feature = Feature(number: number, color: color, symbol: symbol, shade: shade)
                        features.append(feature)
                    }
                }
            }
        }
        
        return features
    }
}

enum FeatureNumber: Int, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
}

enum FeatureColor: CaseIterable {
    case red
    case green
    case purple
}

enum FeatureSymbol: CaseIterable {
    case diamond
    case oval
    case rectangle
}

enum FeatureShade: CaseIterable {
    case filled
    case shaded
    case stroked
}
