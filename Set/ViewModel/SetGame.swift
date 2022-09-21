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
    
    /// 27 sets of 3 cards give a total of 81 cards
    static private let DEFAULT_NUMBER_OF_SETS = 27
    
    // TODO: - Change CardGame Generic to a custom one
    typealias Game = CardGame<Feature>
    typealias Card = Game.Card
    
    // MARK: - Static
    
    static func createSetGame() -> Game {
        let data = Feature.createAllCards().shuffled()
        return Game(numberOfCardSets: 4) { data[$0] }
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
    
    // MARK: - Structs
    
}
