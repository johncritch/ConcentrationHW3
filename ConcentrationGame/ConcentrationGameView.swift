//
//  ContentView.swift
//  ConcentrationHW3
//
//  Created by John Critchlow on 9/7/22.
//

import SwiftUI

struct ConcentrationGameView: View {
    @ObservedObject var emojiGame: EmojiConcentrationGame
    @State private var score: String = "200"
    @State private var highScore: String = "1000"
    
    var body: some View {
        
        VStack {
            Text("Concentration Game")
                .font(.largeTitle)
                .padding()
            Group {
                HStack {
                    Text("Current Score:  \(emojiGame.currentScore)")
                    Spacer()
                    Text("High Score:  \(emojiGame.highScore)")
                }
                .padding(.horizontal, 30.0)
            }
            GeometryReader { geometry in
                LazyVGrid(columns: columns(for: geometry.size)) {
                    ForEach(emojiGame.cards) {card in
                        CardView(card: card)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    emojiGame.choose(card: card)
                                }
                            }
                    }
                }
                .padding()
            }
            Spacer()
            RoundedRectangle(cornerRadius: 20)
                .padding()
                .frame(width: 200.0, height: 75.0)
                .foregroundColor(.red)
                .overlay(Text("New Game").font(.title).foregroundColor(.white))
                .onTapGesture {
                    emojiGame.newGame()
                }
        }
    }
    
    // MARK: - Helpers
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.fixed(Card.desiredWidth)), count: Int(size.width / Card.desiredWidth))
    }
    
    // MARK: -
    
    private struct Card {
        static let desiredWidth: CGFloat = 85
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConcentrationGameView(emojiGame: EmojiConcentrationGame())
    }
}
