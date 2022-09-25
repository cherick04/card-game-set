//
//  Feature.swift
//  Set
//
//  Created by Erick Chacon on 9/20/22.
//

import Foundation

struct Feature: QuadThreeState {
    let stateA: ThreeState
    let stateB: ThreeState
    let stateC: ThreeState
    let stateD: ThreeState
}

extension Feature {

    /// Returns an array of `Feature` that contains all 81 cards
    static func allCards() -> [Feature] {
        var features: [Feature] = []
        for a in ThreeState.allCases {
            for b in ThreeState.allCases {
                for c in ThreeState.allCases {
                    for d in ThreeState.allCases {
                        let feature = Feature(stateA: a, stateB: b, stateC: c, stateD: d)
                        features.append(feature)
                    }
                }
            }
        }
        
        return features
    }
    
    static func someCards() -> [Feature] {
        var features: [Feature] = []
        for a in ThreeState.allCases {
            for b in ThreeState.allCases {
                let feature = Feature(stateA: a, stateB: b, stateC: .triStateA, stateD: .triStateA)
                        features.append(feature)
            }
        }
        
        return features
    }
}
