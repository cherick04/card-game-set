//
//  CardGame.swift
//  Set
//
//  Created by Erick Chacon on 9/20/22.
//

import Foundation

struct CardGame<CardContent> where CardContent: QuadThreeState {
    
    // MARK: - Properties
    
    /// Number of cards that make a set
    private let SET_COUNT: Int = 3
    /// In seconds
    private let BONUS_MAX_TIME: Int = 15
    
    let cardCount: Int
    private(set) var availableCards: [Card]
    private(set) var cardsOnScreen: [Card]
    
    private(set) var score = 0
    private(set) var numberOfSetsFound: Int = 0 {
        willSet {
            // restart bonus timer after finding a set
            if newValue - numberOfSetsFound > 0 {
                bonusPointsDate = Date()
            }
        }
    }
    
    /// Date reference so bonus can be calculated
    private var bonusPointsDate: Date?
    
    var numberOfSets: Int {
        cardCount / SET_COUNT
    }
    
    private var isSetFound = false {
        didSet {
            updateScore()
            numberOfSetsFound += isSetFound ? 1 : 0
            updateCardsSetState()
        }
    }
    
    private var selectedCardIDs: [Int] = [] {
        didSet {
            checkIfCardsFormASet()
        }
    }
    
    private var isPossibleSet: Bool {
        selectedCardIDs.count == SET_COUNT
    }
    
    // MARK: - Initializer
    init(cardCount: Int, screenCardsCount: Int, createCardContent: (Int) -> CardContent) {
        availableCards = []
        for setIndex in 0..<cardCount {
            availableCards.append(Card(content: createCardContent(setIndex), id: setIndex))
        }
        availableCards.shuffle()
        self.cardCount = cardCount
        
        cardsOnScreen = []
        addToScreen(cardCount: screenCardsCount)
        bonusPointsDate = Date()
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
        
        // TODO: Clean this up
        if isPossibleSet {
            if isSetFound {
                if !selectedCardIDs.contains(card.id) {
                    dealMoreCards(count: SET_COUNT)
                } else {
                    return
                }
            } else {
                deselectCards()
            }
        }
        
        
        guard let chosenIndex = cardsOnScreen.firstIndex(where: {$0.id == card.id}) else {
            return
        }
        
        if cardsOnScreen[chosenIndex].isSelected,
           let index =  selectedCardIDs.firstIndex(where: {$0 == card.id}) {
            selectedCardIDs.remove(at: index)
        } else {
            selectedCardIDs.append(card.id)
        }
        cardsOnScreen[chosenIndex].isSelected.toggle()
    }
    
    private mutating func updateCardsSetState() {
        selectedCardIDs.forEach { id in
            if let index = cardsOnScreen.firstIndex(where: {$0.id == id} ) {
                cardsOnScreen[index].isPartOfASet = isSetFound
            }
        }
    }
    
    private mutating func deselectCards() {
        selectedCardIDs.forEach { id in
            if let index = cardsOnScreen.firstIndex(where: {$0.id == id} ) {
                cardsOnScreen[index].isSelected = false
                cardsOnScreen[index].isPartOfASet = nil
            }
        }
        selectedCardIDs = []
    }
    
    private mutating func replaceSetCards() {
        for id in selectedCardIDs {
            guard let index = cardsOnScreen.firstIndex(where: {$0.id == id}) else {
                continue
            }
            
            if let first = availableCards.first {
                cardsOnScreen[index] = first
                availableCards.removeFirst()
            } else {
                cardsOnScreen.remove(at: index)
            }
        }
        selectedCardIDs = []
        isSetFound = false
    }
    
    private mutating func addToScreen(cardCount: Int) {
        for _ in 0..<cardCount {
            if let first = availableCards.first {
                cardsOnScreen.append(first)
                availableCards.removeFirst()
            }
        }
    }
    
    private mutating func updateScore() {
        if isSetFound {
            var timeDifference = BONUS_MAX_TIME
            if let bonusPointsDate = bonusPointsDate {
                timeDifference = Int(Date().timeIntervalSince(bonusPointsDate))
            }
            score += max(BONUS_MAX_TIME - timeDifference, 1)
        } else {
            score -= 1
        }
    }
    
    private mutating func checkIfCardsFormASet() {
        guard isPossibleSet else { return }
        
        let cardContent = cardsOnScreen
            .filter { selectedCardIDs.contains($0.id) }
            .map { $0.content }
        
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
        return Set(states).count == states.count
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
