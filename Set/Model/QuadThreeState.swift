//
//  QuadThreeState.swift
//  Set
//
//  Created by Erick Chacon on 9/22/22.
//

import Foundation

/// Protocol indicates conforming object must have 4 `ThreeState` properties
protocol QuadThreeState {
    var stateA: ThreeState { get }
    var stateB: ThreeState { get }
    var stateC: ThreeState { get }
    var stateD: ThreeState { get }
}
