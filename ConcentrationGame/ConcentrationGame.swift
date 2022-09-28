//
//  ConcentrationGame.swift
//  ConcentrationHW3
//
//  Created by John Critchlow on 9/7/22.
//

import Foundation

struct ConcentrationGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    var currentScore: Int
    var highScore: Int
    var remainingCards: Int
    var newGame: Bool = false
    
    init(numberOfPairsOfCards: Int, gameHighScore: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        currentScore = 0
        highScore = gameHighScore
        remainingCards = numberOfPairsOfCards
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards.shuffle()
    }
    
    mutating func choose(card: Card) -> Bool {
        var resultedInMatch = false
        if let chosenIndex = cards.firstIndex(matching: card),
                             !cards[chosenIndex].isFaceUp,
                             !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    currentScore += 2
                    remainingCards -= 1
                    
                    resultedInMatch = true
                } else {
                    currentScore -= 1
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()

            if remainingCards == 0 {
                if currentScore > highScore {
                    highScore = currentScore
                }
                newGame = true
            }
        }
        return resultedInMatch
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id = UUID()
    }
}


