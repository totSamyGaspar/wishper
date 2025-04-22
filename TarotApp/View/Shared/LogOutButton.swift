//
//  LogOutButton.swift
//  TarotApp
//
//  Created by Edward Gasparian on 21.04.2025.
//

import SwiftUI
import FirebaseAuth

struct LogOutButton: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    
    var body: some View {
        Button(action: {
            do {
                try Auth.auth().signOut()
                isLoggedIn = false
                SoundManager.shared.playEffect(named: "button_click")
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
        }) {
            Image(systemName: "arrow.backward.circle.fill")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.pureGold)
                .background(Color.misteryBlue)
                .clipShape(Circle())
                .padding()
        }
    }
}
