//
//  EmojiConcentrationGame.swift
//  ConcentrationHW3
//
//  Created by John Critchlow on 9/7/22.
//

import SwiftUI

class EmojiConcentrationGame: ObservableObject {
    @Published var game = createGame()
    private var soundPlayer = SoundPlayer()
    
    static private let emojis = ["🐧", "🍀", "🍭", "🍫", "🔥"]

    var currentScore = 0
    var highScore = 0
    
    static private func createGame(highScoreNewGame: Int = 0) -> ConcentrationGame<String> {
        ConcentrationGame<String>(numberOfPairsOfCards: Int.random(in: 2...emojis.count), gameHighScore: highScoreNewGame) {index in
            emojis[index]
        }
    }
    // MARK: - Access to model
    
    var cards: Array<ConcentrationGame<String>.Card> {
        game.cards
    }
    
    // MARK: - Intents
    
    func choose(card: ConcentrationGame<String>.Card) {
        if game.choose(card: card) {
            soundPlayer.playSound(named: "get-up-pierrot-atm-notification-94647.mp3")
        }
        currentScore = game.currentScore
        highScore = game.highScore
        if game.newGame {
            newGame()
        }
    }
    
    func newGame() {
        withAnimation {
            game = EmojiConcentrationGame.createGame(highScoreNewGame: highScore)
        }
    }
}
