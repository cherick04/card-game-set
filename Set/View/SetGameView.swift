//
//  SetGameView.swift
//  Set
//
//  Created by Erick Chacon on 9/18/22.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var game: SetGame
    
    var body: some View {
        VStack {
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                CardView(card: card)
                    .padding(2)
            }
            Spacer()
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
            // TODO: - deal intent
        }
    }
    
    private var newGameButton: some View {
        Button("New Game") {
            // TODO: - new game intent
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGame()
        SetGameView(game: game)
    }
}
