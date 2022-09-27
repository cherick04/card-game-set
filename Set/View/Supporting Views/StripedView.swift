//
//  StripedView.swift
//  Set
//
//  Created by Erick Chacon on 9/26/22.
//

import SwiftUI

struct StripedView: View {
    let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            let itemWidth = DrawingConstants.lineWidth + DrawingConstants.lineSpace
            let items = Int(2 * geometry.size.width / itemWidth)
            HStack(spacing: DrawingConstants.lineSpace) {
                ForEach(0..<items, id: \.self) { _ in
                    color.frame(
                        width: DrawingConstants.lineWidth,
                        height: geometry.size.height
                    )
                }
            }
        }
    }
    
    private struct DrawingConstants {
        static let lineWidth: CGFloat = 2
        static let lineSpace: CGFloat = 3
    }
}
