//
//  SetGameView.swift
//  Set
//
//  Created by Erick Chacon on 9/18/22.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var game: SetCardGame
    
    var body: some View {
        VStack {
            AspectVGrid(items: game.cardsOnScreen, aspectRatio: 2/3) { card in
                SetGameCardView(card: card)
                    .padding(2)
                    .onTapGesture {
                        game.select(card)
                    }
            }
            HStack {
                dealButton
                Spacer()
                newGameButton
            }
            .padding(.horizontal)
        }
        .padding()
    }
    
    private var dealButton: some View {
        Button("Deal 3 cards") {
            game.dealThreeMoreCards()
        }
        .disabled(game.isDeckEmpty)
    }
    
    private var newGameButton: some View {
        Button("New Game") {
            game.newGame()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetCardGame()
        SetGameView(game: game)
    }
}
