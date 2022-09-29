//
//  SetGameView.swift
//  Set
//
//  Created by Erick Chacon on 9/18/22.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var game: SetCardGame
    
    /// Used to temporary track whether a card has been dealt or not.
    /// Contains id's of cards
    @State private var dealt = Set<Int>()
    
    var body: some View {
        VStack {
            score
            gameBody
            HStack {
                dealButton
                Spacer()
                newGameButton
            }
            .padding(.horizontal)
        }
        .padding()
    }
    
    private var gameBody: some View {
        AspectVGrid(
            items: game.cardsOnScreen,
            aspectRatio: 2/3
        ) { card in
            SetGameCardView(card: card)
                .padding(2)
                .onTapGesture {
                    game.select(card)
                }
        }
        .foregroundColor(.red)
//        .foregroundStyle(
//            LinearGradient(
//                colors: [.red, .white, .blue],
//                startPoint: .top,
//                endPoint: .bottom
//            )
//        )
    }
    
    private var score: some View {
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
