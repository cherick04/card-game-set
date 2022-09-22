//
//  SetApp.swift
//  Set
//
//  Created by Erick Chacon on 9/18/22.
//

import SwiftUI

@main
struct SetApp: App {
    var body: some Scene {
        WindowGroup {
            let game = SetCardGame()
            SetGameView(game: game)
        }
    }
}
