//
//  SoundPlayer.swift
//  ConcentrationGame
//
//  Created by John Critchlow on 9/27/22.
//

import Foundation
import AVFoundation

struct SoundPlayer {
    var player: AVAudioPlayer?
    
    mutating func playSound(named soundName: String) {
        guard let path = Bundle.main.url(forResource: soundName, withExtension: nil) else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: path)
            player?.play()
        } catch {
            // Ignore -- don't play sound
        }
    }
}
