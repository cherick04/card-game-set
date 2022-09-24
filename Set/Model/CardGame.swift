//
//  CardGame.swift
//  Set
//
//  Created by Erick Chacon on 9/20/22.
//

import Foundation

struct CardGame<CardContent> where CardContent: QuadThreeState {
    
    // MARK: - Properties
    
    private let SET_COUNT = 3
    
    private(set) var availableCards: [Card]
    private(set) var cardsOnDeck: [Card]
    
    private var isSetFound = false {
        didSet {
            updateCardsSetState()
        }
    }
    
    private var selectedCardIndices: [Int] = [] {
        didSet {
            if isPossibleSet {
                checkIfCardsFormASet()
            }
        }
    }
    
    private var isPossibleSet: Bool {
        selectedCardIndices.count == SET_COUNT
    }
    
    // MARK: - Initializer
    init(cardCount: Int, cardsOnDeckCount: Int, createCardContent: (Int) -> CardContent) {
        availableCards = []
        for setIndex in 0..<cardCount {
            availableCards.append(Card(content: createCardContent(setIndex), id: setIndex))
        }
//        availableCards.shuffle()
        
        cardsOnDeck = []
        addToScreen(cardCount: cardsOnDeckCount)
    }
    
    // MARK: - Methods
    
    mutating func dealMoreCards(count: Int) {
        guard !isSetFound else {
            replaceSetCards()
            return
        }
        
        addToScreen(cardCount: count)
    }
    
    mutating func select(_ card: Card) {
        guard let chosenIndex = cardsOnDeck.firstIndex(where: {$0.id == card.id}) else {
            return
        }
        
        // TODO: Clean this up
        if isPossibleSet {
            if isSetFound {
                if !selectedCardIndices.contains(chosenIndex) {
                    dealMoreCards(count: SET_COUNT)
                } else {
                    return
                }
            } else {
                deselectCards()
            }
        }
        
        if cardsOnDeck[chosenIndex].isSelected,
           let selectedCardIndex = selectedCardIndices.firstIndex(where: {$0 == chosenIndex}) {
            selectedCardIndices.remove(at: selectedCardIndex)
        } else {
            selectedCardIndices.append(chosenIndex)
        }
        cardsOnDeck[chosenIndex].isSelected.toggle()
    }
    
    private mutating func updateCardsSetState() {
        selectedCardIndices.forEach { index in
            cardsOnDeck[index].isPartOfASet = isSetFound
        }
    }
    
    private mutating func deselectCards() {
        selectedCardIndices.forEach { index in
            cardsOnDeck[index].isSelected = false
            cardsOnDeck[index].isPartOfASet = nil
        }
        selectedCardIndices = []
    }
    
    private mutating func replaceSetCards() {
        for index in selectedCardIndices {
            if let first = availableCards.first {
                cardsOnDeck[index] = first
                availableCards.removeFirst()
            }
        }
        selectedCardIndices = []
        isSetFound = false
    }
    
    private mutating func addToScreen(cardCount: Int) {
        for _ in 0..<cardCount {
            if let first = availableCards.first {
                cardsOnDeck.append(first)
                availableCards.removeFirst()
            }
        }
    }
    
    private mutating func checkIfCardsFormASet() {
        guard isPossibleSet else { return }
        
        let cardContent = selectedCardIndices.map { cardsOnDeck[$0].content }
        let allA = cardContent.map(\.stateA)
        let allB = cardContent.map(\.stateB)
        let allC = cardContent.map(\.stateC)
        let allD = cardContent.map(\.stateD)
        isSetFound = (areAllSame(allA) || areAllDifferent(allA))
                && (areAllSame(allB) || areAllDifferent(allB))
                && (areAllSame(allC) || areAllDifferent(allC))
                && (areAllSame(allD) || areAllDifferent(allD))
    }
    
    private func areAllSame(_ states: [ThreeState]) -> Bool {
        states.dropFirst().reduce(true) { (partialResult, state) in
            partialResult && state == states.first
        }
    }
    
    private func areAllDifferent(_ states: [ThreeState]) -> Bool {
        states.dropFirst().reduce(true) { (partialResult, state) in
            partialResult && state != states.first
        }
    }
    
    // MARK: - Other Types
        
    /// Model holding card information
    struct Card: Identifiable {
        var isSelected = false
        var isPartOfASet: Bool?
        let content: CardContent
        let id: Int
    }
}
