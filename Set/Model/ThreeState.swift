//
//  ThreeState.swift
//  Set
//
//  Created by Erick Chacon on 9/22/22.
//

import Foundation

/// Lists all possible states
enum ThreeState {
    case a
    case b
    case c
}

extension ThreeState: CaseIterable {}
