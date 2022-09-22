//
//  Feature.swift
//  Set
//
//  Created by Erick Chacon on 9/20/22.
//

import Foundation

struct Feature {
    let number: ThreeState
    let color: ThreeState
    let symbol: ThreeState
    let shade: ThreeState
}

extension Feature {

    /// Returns an array of `Feature` that contains all 81 cards
    static func allCards() -> [Feature] {
        var features: [Feature] = []
        for number in ThreeState.allCases {
            for color in ThreeState.allCases {
                for symbol in ThreeState.allCases {
                    for shade in ThreeState.allCases {
                        let feature = Feature(number: number, color: color, symbol: symbol, shade: shade)
                        features.append(feature)
                    }
                }
            }
        }
        
        return features
    }
}

extension Feature: Equatable {
    
    static func ==(lhs: Feature, rhs: Feature) -> Bool {
        lhs.number == rhs.number &&
        lhs.color == rhs.color &&
        lhs.symbol == rhs.symbol &&
        lhs.shade == rhs.shade
    }
}
