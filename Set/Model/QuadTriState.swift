//
//  QuadTriState.swift
//  Set
//
//  Created by Erick Chacon on 9/22/22.
//

import Foundation

/// Protocol indicates conforming object must have 4 `TriState` properties
protocol QuadTriState {
    var stateA: TriState { get }
    var stateB: TriState { get }
    var stateC: TriState { get }
    var stateD: TriState { get }
}
