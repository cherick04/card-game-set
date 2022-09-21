//
//  CardGame.swift
//  Set
//
//  Created by Erick Chacon on 9/20/22.
//

import Foundation

struct CardGame<CardContent> {
    
    // MARK: - Properties
    
    private(set) var cards: [Card]
    private(set) var cardsOnDeck: [Card]
    private(set) var selectedCards: [Card]
    
    // MARK: - Initializer
    init(cardCount: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        cardsOnDeck = []
        selectedCards = []
        for setIndex in 0..<cardCount {
            cards.append(Card(content: createCardContent(setIndex), id: setIndex))
        }
        cards.shuffle()
    }
    
    func dealMoreCards() {
        // TODO: -
    }
    
    // MARK: - Other Types
        
    /// Model holding card information
    struct Card: Identifiable {
        var isSet = false
        var content: CardContent
        var id: Int
    }
}
