//
//  Feature.swift
//  Set
//
//  Created by Erick Chacon on 9/20/22.
//

import Foundation

struct Feature {
    let number: FeatureInt
    let color: FeatureColor
    let symbol: FeatureSymbol
    let shade: FeatureShade
    
    // MARK: - Static
    
    /// Returns an array of `Feature` that contains all 81 cards
    static func createAllCards() -> [Feature] {
        var features: [Feature] = []
        for number in FeatureInt.allCases {
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

enum FeatureInt: CaseIterable {
    case one
    case two
    case three
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
