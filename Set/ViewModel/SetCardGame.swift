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
        let data = Feature.nineCards()
        let cardCount = data.count
        let screenCardsCount = min(DEFAULT_NUMBER_OF_CARDS, cardCount)
        return Game(cardCount: cardCount, screenCardsCount: 3) { data[$0] }
    }
    
    // MARK: - Properties
    @Published private var model: Game
    
    var isWon: Bool {
        numberOfSetsFound == numberOfSets
    }
    
    var isDeckEmpty: Bool {
        model.cards.filter({$0.position == .triStateA}).isEmpty
    }
    
    // TODO: delete this property since View will determine which cards to show on screen
    var cardsOnScreen: [Card] {
        model.cards.filter { $0.position == .triStateB }
    }
    
    var cards: [Card] {
        model.cards
    }
    
    var numberOfSetsFound: Int {
        model.numberOfSetsFound
    }
    
    var numberOfSets: Int {
        model.numberOfSets
    }
    
    var score: Int {
        model.score
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
}
