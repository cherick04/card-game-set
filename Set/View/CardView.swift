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
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            shape.fill(.white)
            shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            Text(card.content)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 3
    }
}
