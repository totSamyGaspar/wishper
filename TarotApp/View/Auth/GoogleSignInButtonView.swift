//
//  SwiftUIView.swift
//  TarotApp
//
//  Created by Edward Gasparian on 19.04.2025.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth
import FirebaseCore

struct GoogleSignInButtonView: View {
    var onSignIn: () -> Void
    
    var body: some View {
        Button(action: {
            signInWithGoogle()
        }) {
            HStack {
                Image(systemName: "globe")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("Sign in with Google")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.pureGold)
            .foregroundColor(.misteryBlue)
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
        }
        .padding(.horizontal)
    }
    
    private func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("❌ Не удалось получить rootViewController")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                print("❌ Google Sign-in error: \(error.localizedDescription)")
                return
            }
            
            guard
                let user = result?.user,
                let idToken = user.idToken?.tokenString
            else {
                print("❌ Не удалось получить токены")
                return
            }
            let accessToken = user.accessToken.tokenString
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("❌ Firebase sign-in error: \(error.localizedDescription)")
                } else {
                    print("✅ Successfully signed in with Google: \(authResult?.user.uid ?? "")")
                    onSignIn()
                }
            }
        }
    }
}

#Preview {
    GoogleSignInButtonView {
        print("✅ Signed in (preview mock)")
    }
    .padding()
}
