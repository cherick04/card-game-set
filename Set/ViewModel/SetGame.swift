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
    static private let DEFAULT_NUMBER_OF_CARDS = 12
    
    // TODO: - Change CardGame Generic to a custom one
    typealias Game = CardGame<Feature>
    typealias Card = Game.Card
    
    // MARK: - Static
    
    static func createSetGame() -> Game {
        let data = Feature.allCards().shuffled()
        let cardsOnDeckCount = min(DEFAULT_NUMBER_OF_CARDS, data.count)
        return Game(cardCount: data.count, cardsOnDeckCount: cardsOnDeckCount) { data[$0] }
    }
    
    // MARK: - Properties
    @Published private(set) var model: Game
    
    /// Array of all cards to be used in game
    var cards: [Card] {
        model.cards
    }
    /// Array of cards showing up on deck
    var cardsOnDeck: [Card] {
        model.cardsOnDeck
    }
    
    // MARK: - Initializer
    
    init() {
        model = SetGame.createSetGame()
    }
    
    // MARK: - Intent(s)
    
    func newGame() {
        model = SetGame.createSetGame()
    }
    
    func dealThreeMoreCards() {
        model.dealMoreCards(count: 3)
    }
    
    // MARK: - Structs
    
}
