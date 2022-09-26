//
//  SetGameCardView.swift
//  Set
//
//  Created by Erick Chacon on 9/20/22.
//

import SwiftUI

struct SetGameCardView: View {
    let card: SetCardGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                getContent(for: geometry.size)
                if card.isSelected {
                    if let isPartOfASet = card.isPartOfASet {
                        shape
                            .fill(isPartOfASet ? DrawingConstants.setMatchColor : DrawingConstants.setUnmatchColor)
                            .opacity(DrawingConstants.selectedOpacity)
                    } else {
                        shape.fill(.blue).opacity(DrawingConstants.selectedOpacity)
                    }
                }
            }
        }
    }
    
    /// Diamond shape
    private var diamondSymbol: some View {
        let color = getColor()
        return ZStack {
            if isStriped() {
                StripedView(color: color)
                    .mask(Diamond())
            }
            Diamond()
                .fill(color)
                .opacity(getOpacity())
            Diamond()
                .stroke(lineWidth: DrawingConstants.lineWidth)
        }
        .foregroundColor(color)
    }
    
    /// Oval shape
    private var ovalSymbol: some View {
        let color = getColor()
        return ZStack {
            if isStriped() {
                StripedView(color: color)
                    .mask(Ellipse())
            }
            Ellipse()
                .fill(color)
                .opacity(getOpacity())
            Ellipse()
                .strokeBorder(lineWidth: DrawingConstants.lineWidth)
        }
        .foregroundColor(color)
    }
    
    /// Rectangle Shape
    private var rectangleSymbol: some View {
        let color = getColor()
        return ZStack {
            if isStriped() {
                StripedView(color: color)
                    .mask(Rectangle())
            }
            Rectangle()
                .fill(color)
                .opacity(getOpacity())
            Rectangle()
                .strokeBorder(lineWidth: DrawingConstants.lineWidth)
        }
        .foregroundColor(color)
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
        switch card.content.stateA {
        case .triStateA:
            diamondSymbol
        case .triStateB:
            ovalSymbol
        case .triStateC:
            rectangleSymbol
        }
    }
    
    private func getNumber() -> Int {
        switch card.content.stateB {
        case .triStateA:
            return 1
        case .triStateB:
            return 2
        case .triStateC:
            return 3
        }
    }
    
    private func getOpacity() -> Double {
        switch card.content.stateC {
        case .triStateA:
            return 1
        case .triStateB, .triStateC:
            return 0
        }
    }
    
    private func isStriped() -> Bool {
        return card.content.stateC == .triStateB
    }
    
    private func getColor() -> Color {
        switch card.content.stateD {
        case .triStateA:
            return .red
        case .triStateB:
            return .green
        case .triStateC:
            return .purple
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 2
        static let selectedOpacity: CGFloat = 0.25
        static let setMatchColor: Color = .green
        static let setUnmatchColor: Color = .red
    }
}
