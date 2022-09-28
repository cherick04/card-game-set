//
//  CardGame.swift
//  Set
//
//  Created by Erick Chacon on 9/20/22.
//

import Foundation

struct CardGame<CardContent> where CardContent: QuadTriState {
    
    // MARK: - Properties
    
    /// Number of cards that make a set
    private let SET_COUNT: Int = 3
    /// In seconds
    private let BONUS_MAX_TIME: Int = 15
    
    private var lastCardOnScreenIndex: Int
    private(set) var cards: [Card]
    
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
        cards.count / SET_COUNT
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
        lastCardOnScreenIndex = -1
        cards = []
        for setIndex in 0..<cardCount {
            cards.append(Card(content: createCardContent(setIndex), id: setIndex))
        }
        cards.shuffle()
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
        
        
        guard let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) else {
            return
        }
        
        if cards[chosenIndex].isSelected,
           let index =  selectedCardIDs.firstIndex(where: {$0 == card.id}) {
            selectedCardIDs.remove(at: index)
        } else {
            selectedCardIDs.append(card.id)
        }
        cards[chosenIndex].isSelected.toggle()
    }
    
    private mutating func updateCardsSetState() {
        selectedCardIDs.forEach { id in
            if let index = cards.firstIndex(where: {$0.id == id} ) {
                cards[index].isPartOfASet = isSetFound
            }
        }
    }
    
    private mutating func deselectCards() {
        selectedCardIDs.forEach { id in
            if let index = cards.firstIndex(where: {$0.id == id} ) {
                cards[index].isSelected = false
                cards[index].isPartOfASet = nil
            }
        }
        selectedCardIDs = []
    }
    
    private mutating func replaceSetCards() {
        // TODO: Refactor
        for id in selectedCardIDs {
            guard let index = cards.firstIndex(where: {$0.id == id}) else {
                continue
            }
            
            let newIndex = lastCardOnScreenIndex + 1
            cards[index].position = .triStateC
            cards[newIndex].position = .triStateB
            lastCardOnScreenIndex = newIndex
        }
        selectedCardIDs = []
        isSetFound = false
    }
    
    private mutating func addToScreen(cardCount: Int) {
        // TODO: Works, but brings difficulty when replacing cards
        let startIndex = lastCardOnScreenIndex + 1
        let endIndex = startIndex + cardCount
        for index in startIndex..<endIndex {
            cards[index].position = .triStateB
            lastCardOnScreenIndex = index
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
        
        let cardContent = cards
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
    
    private func areAllSame(_ states: [TriState]) -> Bool {
        states.dropFirst().reduce(true) { (partialResult, state) in
            partialResult && state == states.first
        }
    }
    
    private func areAllDifferent(_ states: [TriState]) -> Bool {
        return Set(states).count == states.count
    }
    
    // MARK: - Other Types
        
    /// Model holding card information
    struct Card: Identifiable {
        /// - `triStateA`: on deck
        /// - `triStateB`: on screen
        /// - `triStateC`: discarded
        var position: TriState = .triStateA
        var isSelected = false
        var isPartOfASet: Bool?
        let content: CardContent
        let id: Int
    }
}
