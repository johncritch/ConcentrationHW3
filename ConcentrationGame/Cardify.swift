//
//  Cardify.swift
//  ConcentrationGame
//
//  Created by John Critchlow on 9/20/22.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: Card.cornerRadius).fill(.white)
                RoundedRectangle(cornerRadius: Card.cornerRadius).stroke()
            } else {
                RoundedRectangle(cornerRadius: Card.cornerRadius)
            }
            
            content.opacity(isFaceUp ? 1:0)
        }
        .transition(.scale)
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
    //MARK: - Drawing constants
    
    private struct Card {
        static let cornerRadius: Double = 10
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
