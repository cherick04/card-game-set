//
//  CardView.swift
//  Set
//
//  Created by Erick Chacon on 9/20/22.
//

import SwiftUI

struct CardView: View {
    let card: SetCardGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                getContent(for: geometry.size)
                if card.isSelected {
                    shape.fill(.blue).opacity(DrawingConstants.selectedOpacity)
                }
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
                .stroke(lineWidth: DrawingConstants.lineWidth)
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
                .strokeBorder(lineWidth: DrawingConstants.lineWidth)
        }
        .foregroundColor(getColor())
    }
    
    /// Rectangle Shape
    private var rectangleSymbol: some View {
        ZStack {
            Rectangle()
                .fill(getColor())
                .opacity(getOpacity())
            Rectangle()
                .strokeBorder(lineWidth: DrawingConstants.lineWidth)
        }
        .foregroundColor(getColor())
    }
    
    /// Creates content for the card.
    private func getContent(for size: CGSize) -> some View {
        LazyVGrid(columns: [GridItem(.fixed(size.width / 1.5))]) {
            // Repeat symbol creation based on card number feature
            ForEach(1...getNumber(), id: \.self) { _ in
                getSymbol().aspectRatio(2, contentMode: .fit)
            }
        }
    }
    
    @ViewBuilder
    private func getSymbol() -> some View {
        switch card.content.symbol {
        case .a:
            diamondSymbol
        case .b:
            ovalSymbol
        case .c:
            rectangleSymbol
        }
    }
    
    private func getNumber() -> Int {
        switch card.content.number {
        case .a:
            return 1
        case .b:
            return 2
        case .c:
            return 3
        }
    }
    
    private func getOpacity() -> Double {
        switch card.content.shade {
        case .a:
            return 1
        case .b:
            return 0.5
        case .c:
            return 0
        }
    }
    
    private func getColor() -> Color {
        switch card.content.color {
        case .a:
            return .red
        case .b:
            return .green
        case .c:
            return .purple
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 2
        static let selectedOpacity: CGFloat = 0.25
    }
}
