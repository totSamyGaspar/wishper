//
//  SoundManager.swift
//  TarotApp
//
//  Created by Edward Gasparian on 21.04.2025.
//

import SwiftUI
import Foundation
import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    
    private var backgroundPlayer: AVAudioPlayer?
    private var effectPlayer: AVAudioPlayer?
    
    @AppStorage("isSoundEnabled") var isSoundEnabled: Bool = true
    @AppStorage("isMusicEnabled") var isMusicEnabled: Bool = true
    
    @AppStorage("musicVolume") var backgroundVolume: Double = 0.5
    @AppStorage("effectsVolume") var effectVolume: Double = 1.0
    
    // MARK: - Background Music
    func playBackgroundMusic(named name: String, fileExtension: String = "mp3") {
        guard isMusicEnabled,
              let url = Bundle.main.url(forResource: name, withExtension: fileExtension) else {
            print("Background music not found")
            return
        }
        
        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer?.volume = Float(backgroundVolume)
            backgroundPlayer?.numberOfLoops = -1
            backgroundPlayer?.play()
        } catch {
            print("Failed to play background music:", error.localizedDescription)
        }
    }
    func updateBackgroundVolume(to value: Float) {
        backgroundVolume = Double(value)
        backgroundPlayer?.volume = value
    }
    
    func stopBackgroundMusic() {
        backgroundPlayer?.stop()
    }
    
    
    
    
    // MARK: - Sound Effects
    func playEffect(named name: String, fileExtension: String = "mp3") {
        guard isSoundEnabled,
              let url = Bundle.main.url(forResource: name, withExtension: fileExtension) else {
            print("Sound effect not found")
            return
        }
        
        do {
            effectPlayer = try AVAudioPlayer(contentsOf: url)
            effectPlayer?.volume = Float(effectVolume)
            effectPlayer?.play()
        } catch {
            print("Failed to play effect:", error.localizedDescription)
        }
    }
    func updateEffectVolume(to value: Float) {
        effectVolume = Double(value)
        effectPlayer?.volume = value
    }
}

