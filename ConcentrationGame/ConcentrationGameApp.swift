//
//  ConcentrationHW3App.swift
//  ConcentrationHW3
//
//  Created by John Critchlow on 9/7/22.
//

import SwiftUI

@main
struct ConcentrationGameApp: App {
    var body: some Scene {
        WindowGroup {
            ConcentrationGameView(emojiGame: EmojiConcentrationGame())
        }
    }
}
