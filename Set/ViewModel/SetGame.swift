//
//  SetGame.swift
//  Set
//
//  Created by Erick Chacon on 9/20/22.
//

import Foundation
import SwiftUI
import UIKit

class SetGame: ObservableObject {
    
    // TODO: - Change CardGame Generic to a custom one
    typealias Game = CardGame<String>
    typealias Card = Game.Card
    
    // MARK: - Static
    
    static func createSetGame() -> Game {
        let data = ["A", "B", "C", "A", "B", "C", "A", "B", "C", "A", "B", "C"]
        return Game(numberOfCardSets: 3) { data[$0] }
    }
    
    // MARK: - Properties
    @Published private(set) var model: Game
    
    /// Array of all cards to be used in game
    var cards: [Card] {
        model.cards
    }
    
    // MARK: - Initializer
    
    init() {
        model = SetGame.createSetGame()
    }
    
    // MARK: - Intent(s)
}
