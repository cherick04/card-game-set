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
                getContent(for: geometry.size)
            }
        }
    }
    
    /// Creates content for the card.
    @ViewBuilder
    private func getContent(for size: CGSize) -> some View {
        LazyVGrid(columns: [GridItem(.fixed(size.width / 1.5))]) {
            ForEach(0..<card.content.number.rawValue, id: \.self) { _ in
                getSymbol().aspectRatio(2, contentMode: .fit)
            }
        }
    }
    
    /// Diamond shape
    private var diamondSymbol: some View {
        ZStack {
            Diamond()
                .fill(getColor())
                .opacity(getOpacity())
            Diamond()
                .stroke(lineWidth: 3)
        }
        .foregroundColor(getColor())
    }
    
    /// Oval shape
    private var ovalSymbol: some View {
        ZStack {
            Ellipse()
                .fill(getColor())
                .opacity(getOpacity())
            Ellipse()
                .strokeBorder(lineWidth: 3)
        }
        .foregroundColor(getColor())
    }
    
    /// Rectangle Shape
    private var rectangleSymbol: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(getColor())
                .opacity(getOpacity())
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(lineWidth: 3)
        }
        .foregroundColor(getColor())
    }
    
    @ViewBuilder
    private func getSymbol() -> some View {
        switch card.content.symbol {
        case .diamond:
            diamondSymbol
        case .oval:
            ovalSymbol
        case .rectangle:
            rectangleSymbol
        }
    }
    
    private func getOpacity() -> Double {
        switch card.content.shade {
        case .filled:
            return 1
        case .shaded:
            return 0.5
        case .stroked:
            return 0
        }
    }
    
    private func getColor() -> Color {
        switch card.content.color {
        case .red:
            return .red
        case .green:
            return .green
        case .purple:
            return .purple
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 3
    }
}
