//
//  SetGameView.swift
//  Set
//
//  Created by Erick Chacon on 9/18/22.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var game: SetCardGame
    
    // a token which provides a namespace for the id's used in matchGeometryEffect
    @Namespace private var dealingNamespace
    
    var body: some View {
        VStack {
            header
            gameBody
            HStack {
                deckBody
                Spacer()
                newGameButton
                Spacer()
                discardedBody
            }
            .padding(.horizontal)
        }
        .padding()
    }
    
    /// Metrics of the game
    private var header: some View {
        HStack {
            if game.isWon {
                Text("YOU WON!!!").fontWeight(.bold).foregroundColor(.green)
            } else {
                Text("Sets:")
                Text("\(game.numberOfSetsFound)/\(game.numberOfSets)")
            }
            Spacer()
            Text("Score:")
            if game.score > 0 {
                Text(String(game.score)).foregroundColor(.green)
            } else if game.score < 0 {
                Text(String(game.score)).foregroundColor(.red)
            } else {
                Text(String(game.score))
            }
        }
        .font(.system(size: 15))
        .padding(.vertical, -5.0)
    }
    
    /// The body of all cards on screen to be played with
    private var gameBody: some View {
        AspectVGrid(
            items: game.cards.filter(isOnScreen),
            aspectRatio: CardConstants.aspectRatio
        ) { card in
            SetGameCardView(card: card)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .padding(2)
                .transition(.asymmetric(insertion: .identity, removal: .scale))
                .zIndex(zIndex(of: card))
                .onTapGesture {
                    withAnimation(selectAnimation()) {
                        game.select(card)
                    }
                }
        }
        .foregroundColor(CardConstants.color)
    }
    
    /// The body of the deck
    private var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isOnDeck)) { card in
                SetGameCardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            for _ in 0..<3 {
                withAnimation(dealAnimation()) {
                    game.dealCard()
                }
            }
        }
    }
    
    /// The body of discarded cards
    private var discardedBody: some View {
        ZStack {
            ForEach(game.cards.filter(isDiscarded)) { card in
                SetGameCardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
    }
    
    private var newGameButton: some View {
        Button("New Game") {
            withAnimation(.easeInOut(duration: 1)) {
                game.newGame()
            }
        }
    }
    
    private func isOnDeck(_ card: SetCardGame.Card) -> Bool {
        card.position == .triStateA
    }
    
    private func isOnScreen(_ card: SetCardGame.Card) -> Bool {
        card.position == .triStateB
    }
    
    private func isDiscarded(_ card: SetCardGame.Card) -> Bool {
        card.position == .triStateC
    }
    
    // an Animation used to deal the cards out "not all at the same time"
    // the Animation is delayed depending on the index of the given card
    //  in our ViewModel's (and thus our Model's) cards array
    // the further the card is into that array, the more the animation is delayed
    private func dealAnimation() -> Animation {
        .easeInOut(duration: CardConstants.dealDuration).delay(CardConstants.dealDelay)
    }
    
    private func selectAnimation() -> Animation {
        .easeIn(duration: CardConstants.selectDuration)
    }
    
    /// Inverts order of cards
    private func zIndex(of card: SetCardGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let selectDuration: Double = 0.25
        static let dealDelay: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 100
        static let undealtWidth = undealtHeight * aspectRatio
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetCardGame()
        SetGameView(game: game)
    }
}
