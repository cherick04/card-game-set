//
//  CardView.swift
//  Set
//
//  Created by Erick Chacon on 9/20/22.
//

import SwiftUI

struct CardView: View {
    // TODO: - create Card struct with content
    let card: SetGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                getSymbol()
                    
            }
        }
    }
    
    @ViewBuilder
    private func getSymbol() -> some View {
        switch card.content.symbol {
        case .diamond:
            Circle()
                .strokeBorder(lineWidth: 3)
                .foregroundColor(getColor())
                .opacity(getOpacity())
        case .oval:
            Ellipse()
                .strokeBorder(lineWidth: 3)
                .foregroundColor(getColor())
                .opacity(getOpacity())
        case .rectangle:
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(lineWidth: 3)
                .foregroundColor(getColor())
                .opacity(getOpacity())
        }
    }
    
    private func getOpacity() -> Double {
        switch card.content.shade {
        case .filled: return 1
        case .shaded: return 0.5
        case .stroked: return 0
        }
    }
    
    private func getColor() -> Color {
        switch card.content.color {
        case .red: return .red
        case .green: return .green
        case .purple: return .purple
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 3
    }
}

struct CardContentView<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    let items: [Item]
    let content: (Item) -> ItemView
    
    init(items: [Item], @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 5) {
                ForEach(items) { item in
                    content(item)
                }
            }
        }
    }
}
