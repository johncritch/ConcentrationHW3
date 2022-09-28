//
//  CardView.swift
//  ConcentrationHW3
//
//  Created by John Critchlow on 9/13/22.
//

import SwiftUI

struct CardView: View {
    var card: ConcentrationGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            if !card.isMatched || card.isFaceUp {
                ZStack {
                    let animation = Animation.linear(duration: 1.0).repeatForever(autoreverses: false)
                    Pie(startAngle: Angle(degrees: 360-90), endAngle: Angle(degrees: 105-90))
                        .padding()
                        .opacity(0.4)
                    Text(card.content)
                        .font(systemFont(for: geometry.size))
                        .rotationEffect(Angle(degrees: card.isMatched ? 360: 0))
                        .animation(animation, value: card.isMatched)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .foregroundColor(.blue)
            }
        }
        .aspectRatio(Card.aspectRatio, contentMode: .fit)
    }
    // MARK: - Helpers
    
    private func systemFont(for size: CGSize) -> Font {
        return Font.system(size: min(size.width, size.height) * Card.fontScaleFactor)
    }
    
    //MARK: - Drawing constants
    
    private struct Card {
        static let aspectRatio: Double = 2/3
        static let cornerRadius: Double = 10
        static let fontScaleFactor: CGFloat = 0.75
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: ConcentrationGame<String>.Card(isFaceUp: true, content: "🛎"))
            .padding(100)
    }
}
