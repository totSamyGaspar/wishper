//
//  SignUpView.swift
//  TarotApp
//
//  Created by Edward Gasparian on 19.04.2025.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    @State private var isLoading = false
    @State private var selectedTab: AuthTab = .signIn
    
    @AppStorage("isLoggedIn") var isLoggedIn = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                MagicParticlesView(width: geo.size.width, height: geo.size.height)
                
                VStack(spacing: 0) {
                    
                    // MARK: - Tabs
                    HStack {
                        ForEach(AuthTab.allCases, id: \.self) { tab in
                            Button(action: {
                                withAnimation {
                                    selectedTab = tab
                                }
                            }) {
                                Text(tab.rawValue)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        selectedTab == tab ?
                                        Color.white.opacity(0.15) :
                                            Color.clear
                                    )
                                    .foregroundColor(selectedTab == tab ? .yellow : .white)
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .fontDesign(.rounded)
                    .padding(.horizontal, 25)
                    .padding(.top)
                    
                    Divider()
                        .background(Color.white.opacity(0.3))
                    
                    ScrollView {
                        VStack(spacing: 150) {
                            Spacer()
                            GoogleSignInButtonView {
                                isLoggedIn = true
                            }
                            
                            Group {
                                if selectedTab == .signIn {
                                    signInForm
                                } else {
                                    registerForm
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .background(
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
            )
        }
    }
    
    // MARK: - Sign In Form
    private var signInForm: some View {
        VStack(spacing: 15) {
            Text("Sign In")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
            
            Button("Log In", action: loginUser)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.pureGold)
                .foregroundColor(.misteryBlue)
                .cornerRadius(10)
                .disabled(email.isEmpty || password.isEmpty || isLoading)
        }
    }
    
    // MARK: - Register Form
    private var registerForm: some View {
        VStack(spacing: 15) {
            Text("Create Account")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
            
            Button("Sign Up", action: registerUser)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.pureGold)
                .foregroundColor(.misteryBlue)
                .cornerRadius(10)
                .disabled(email.isEmpty || password.isEmpty || isLoading)
        }
    }
    
    // MARK: - Firebase methods
    
    private func loginUser() {
        errorMessage = nil
        isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            isLoading = false
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                isLoggedIn = true
            }
        }
    }
    
    private func registerUser() {
        errorMessage = nil
        isLoading = true
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            isLoading = false
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .emailAlreadyInUse:
                    errorMessage = "This email is already registered. Please log in."
                case .invalidEmail:
                    errorMessage = "Invalid email address."
                case .weakPassword:
                    errorMessage = "Password should be at least 6 characters."
                default:
                    errorMessage = error.localizedDescription
                }
            } else {
                isLoggedIn = true
            }
        }
    }
}

#Preview {
    SignUpView()
}
