//
//  ContentView.swift
//  TarotApp
//
//  Created by Edward Gasparian on 07.04.2025.
//

import SwiftUI
import FirebaseAuth

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @State private var isSplashDone = false
    
    var body: some View {
        ZStack {
            if !isSplashDone {
                SplashView(isActive: $isSplashDone)
                    .transition(.opacity)
            } else {
                if isLoggedIn {
                    HomeView()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity).combined(with: .scale(scale: 0.5)),
                            removal: .scale(scale: 0.5).combined(with: .opacity)
                        ))
                } else {
                    SignUpView()
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .animation(.easeInOut(duration: 0.6), value: isLoggedIn)
        .animation(.easeInOut(duration: 0.6), value: isSplashDone)
        .onAppear {
            SoundManager.shared.playBackgroundMusic(named: "background_music")
            if Auth.auth().currentUser != nil {
                isLoggedIn = true
            }
        }
    }
}
#Preview {
    ContentView()
}
