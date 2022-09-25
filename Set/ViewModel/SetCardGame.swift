//
//  SetCardGame.swift
//  Set
//
//  Created by Erick Chacon on 9/20/22.
//

//import Foundation
import SwiftUI
//import UIKit

class SetCardGame: ObservableObject {
    
    static private let DEFAULT_NUMBER_OF_CARDS = 12
    
    // TODO: - Change CardGame Generic to a custom one
    typealias Game = CardGame<Feature>
    typealias Card = Game.Card
    
    // MARK: - Static
    
    static func createSetGame() -> Game {
        let data = Feature.allCards()
        let screenCardsCount = min(DEFAULT_NUMBER_OF_CARDS, data.count)
        return Game(cardCount: data.count, screenCardsCount: screenCardsCount) { data[$0] }
    }
    
    // MARK: - Properties
    @Published private var model: Game
    
    var isDeckEmpty: Bool {
        model.availableCards.isEmpty
    }
    
    /// Array of cards showing up on deck
    var cardsOnScreen: [Card] {
        model.cardsOnScreen
    }
    
    // MARK: - Initializer
    
    init() {
        model = SetCardGame.createSetGame()
    }
    
    // MARK: - Intent(s)
    
    func newGame() {
        model = SetCardGame.createSetGame()
    }
    
    func dealThreeMoreCards() {
        model.dealMoreCards(count: 3)
    }
    
    func select(_ card: Card) {
        model.select(card)
    }
    
    // MARK: - Structs
    
}
