//
//  Diamond.swift
//  Set
//
//  Created by Erick Chacon on 9/21/22.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radiusHeight = rect.height / 2
        let radiusWidth = rect.width / 2
        let top = CGPoint(
            x: center.x,
            y: center.y - radiusHeight
        )
        let right = CGPoint(
            x: center.x + radiusWidth,
            y: center.y
        )
        let bottom = CGPoint(
            x: center.x,
            y: center.y + radiusHeight
        )
        let left = CGPoint(
            x: center.x - radiusWidth,
            y: center.y
        )
        
        return Path { p in
            p.move(to: top)
            p.addLine(to: right)
            p.addLine(to: bottom)
            p.addLine(to: left)
            p.addLine(to: top)
        }
    }
}
