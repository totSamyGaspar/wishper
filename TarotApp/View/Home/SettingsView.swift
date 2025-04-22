//
//  SettingsView.swift
//  TarotApp
//
//  Created by Edward Gasparian on 08.04.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("language") private var language: String = "ua"
    
    @AppStorage("isSoundEnabled") var isSoundEnabled: Bool = true
    @AppStorage("isMusicEnabled") var isMusicEnabled: Bool = true
    
    @AppStorage("musicVolume") var backgroundVolume: Double = 0.5
    @AppStorage("effectsVolume") var effectVolume: Double = 1.0
    
    var body: some View {
        Form {
            Section(header: Text("Язик / Language / Язык")) {
                Picker("Language", selection: $language) {
                    Text("🇺🇦 Українська").tag("ua")
                    Text("🇬🇧 English").tag("en")
                    Text("🇷🇺 Русский").tag("ru")
                }
                .pickerStyle(.wheel)
            }
            
            //MARK: - Sound toggles and volume scale
            Section(header: Text("Звук / Sound")) {
                
                Toggle(Localized.t(.backgroundMusic, lang: language), isOn: $isMusicEnabled)
                    .onChange(of: isMusicEnabled) {
                        if $1 {
                            SoundManager.shared.playBackgroundMusic(named: "background_music")
                        } else {
                            SoundManager.shared.stopBackgroundMusic()
                        }
                    }
                
                if isMusicEnabled {
                    Slider(value: $backgroundVolume, in: 0...1, step: 0.05) {
                        Text("Музыка")
                    }
                    .onChange(of: backgroundVolume) {
                        SoundManager.shared.updateBackgroundVolume(to: Float($1))
                    }
                }
                
                
                Toggle(Localized.t(.soundEffect, lang: language), isOn: $isSoundEnabled)
                
                if isSoundEnabled {
                    Slider(value: $effectVolume, in: 0...1, step: 0.05) {
                        Text("Эффекты")
                    }
                    .onChange(of: effectVolume) {
                        SoundManager.shared.updateEffectVolume(to: Float($1))
                    }
                }
            }
        }
        .navigationTitle(Text(Localized.t(.settings, lang: language)))
        .onAppear {
            SoundManager.shared.playEffect(named: "button_click")
        }
    }
}

#Preview {
    SettingsView()
}
