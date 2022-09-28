//
//  Feature.swift
//  Set
//
//  Created by Erick Chacon on 9/20/22.
//

import Foundation

struct Feature: QuadTriState {
    let stateA: TriState
    let stateB: TriState
    let stateC: TriState
    let stateD: TriState
}

extension Feature {

    /// Returns an array of `Feature` that contains all 81 cards
    static func allCards() -> [Feature] {
        var features: [Feature] = []
        for a in TriState.allCases {
            for b in TriState.allCases {
                for c in TriState.allCases {
                    for d in TriState.allCases {
                        let feature = Feature(stateA: a, stateB: b, stateC: c, stateD: d)
                        features.append(feature)
                    }
                }
            }
        }
        
        return features
    }
    
    /// Returns 12 cards
    static func someCards() -> [Feature] {
        var features: [Feature] = []
        for a in TriState.allCases {
            for b in TriState.allCases {
                let feature = Feature(stateA: a, stateB: b, stateC: .triStateA, stateD: .triStateA)
                features.append(feature)
            }
        }
        
        return features
    }
}
