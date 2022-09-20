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
    
    // MARK: - Initializer
    init(numberOfCardSets: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for setIndex in 0..<numberOfCardSets {
            let content = createCardContent(setIndex)
            cards.append(Card(content: content, id: setIndex * 3))
            cards.append(Card(content: content, id: setIndex * 3 + 1))
            cards.append(Card(content: content, id: setIndex * 3 + 2))
        }
    }
    
    // MARK: - Other Types
        
    /// Model holding card information
    struct Card: Identifiable {
        var isSet = false
        var content: CardContent
        var id: Int
    }
}
