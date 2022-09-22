//
//  CardGame.swift
//  Set
//
//  Created by Erick Chacon on 9/20/22.
//

import Foundation

struct CardGame<CardContent> where CardContent: Equatable {
    
    // MARK: - Properties
    
    private(set) var cards: [Card]
    private(set) var cardsOnDeck: [Card]
    
    private var selectedCardIndices: [Int] = []
    private var isPossibleSetSelected: Bool {
        selectedCardIndices.count == 3
    }
    
    // MARK: - Initializer
    init(cardCount: Int, cardsOnDeckCount: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for setIndex in 0..<cardCount {
            cards.append(Card(content: createCardContent(setIndex), id: setIndex))
        }
        cards.shuffle()
        cardsOnDeck = Array(cards[0..<cardsOnDeckCount])
    }
    
    // MARK: - Methods
    mutating func dealMoreCards(count: Int) {
        let startIndex = cardsOnDeck.count
        let endIndex = min(cardsOnDeck.count + count, cards.count)
        for card in cards[startIndex..<endIndex] {
            cardsOnDeck.append(card)
        }
    }
    
    mutating func select(_ card: Card) {
        guard let chosenIndex = cardsOnDeck.firstIndex(where: {$0.id == card.id}),
              !isPossibleSetSelected else {
            return
        }
            
        if cardsOnDeck[chosenIndex].isSelected,
           let selectedCardIndex = selectedCardIndices.firstIndex(where: {$0 == chosenIndex}) {
            selectedCardIndices.remove(at: selectedCardIndex)
        } else {
            selectedCardIndices.append(chosenIndex)
        }
        cardsOnDeck[chosenIndex].isSelected.toggle()
}
    
    // TODO: - Revise method
    private func checkIfCardsFormASet() {
        guard selectedCardIndices.count == 3 else { return }
        
        let cards = selectedCardIndices.map { cardsOnDeck[$0].content }
        let isSet = areAllSame(first: cards[0], second: cards[1], third: cards[2]) ||
            areAllDifferent(first: cards[0], second: cards[1], third: cards[2])
    }
    
    private func areAllSame(first: CardContent, second: CardContent, third: CardContent) -> Bool {
        first == second && second == third
    }
    
    private func areAllDifferent(first: CardContent, second: CardContent, third: CardContent) -> Bool {
        first != second && second != third && third != first
    }
    
    // MARK: - Other Types
        
    /// Model holding card information
    struct Card: Identifiable {
        var isSet = false
        var isSelected = false
        let content: CardContent
        let id: Int
    }
}
