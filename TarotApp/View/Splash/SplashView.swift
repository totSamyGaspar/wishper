//
//  SplashView.swift
//  TarotApp
//
//  Created by Edward Gasparian on 13.04.2025.
//

import SwiftUI

struct SplashView: View {
    @State private var showEnterButton = false
    @Binding var isActive: Bool
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
                Image("background")
                    .resizable()
                    .cornerRadius(20)
                    .ignoresSafeArea()
                    .overlay {
                        Rectangle()
                            .fill(Color.black.opacity(0.2))
                            .edgesIgnoringSafeArea(.all)
                    }
                
                MagicParticlesView(width: UIScreen.main.bounds.width,
                                   height: UIScreen.main.bounds.height)
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    Text("Arcane Whisper")
                        .font(.system(size: 48, weight: .bold, design: .serif))
                        .foregroundColor(.pureGold)
                        .minimumScaleFactor(0.5)
                        .shadow(color: .white.opacity(0.3), radius: 10)
                        .opacity(showEnterButton ? 1 : 0)
                        .animation(.easeIn(duration: 1.2), value: showEnterButton)
                        .lineLimit(1)
                        .padding(.horizontal, 40)
                    
                    Text("Unveil your destiny...")
                        .font(.title3)
                        .italic()
                        .foregroundColor(.pureGold.opacity(0.8))
                        .opacity(showEnterButton ? 1 : 0)
                        .animation(.easeIn(duration: 1.5).delay(0.2), value: showEnterButton)
                    
                    Spacer()
                    
                    if showEnterButton {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isActive = true
                            }
                        }) {
                            Text("Enter the Realm")
                                .fontWeight(.semibold)
                                .padding()
                                .frame(maxWidth: 220)
                                .background(Color.pureGold)
                                .foregroundColor(.misteryBlue)
                                .cornerRadius(12)
                                .shadow(radius: 6)
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .padding(.bottom, 50)
                    }
                }
                .padding()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeOut(duration: 2.5)) {
                        showEnterButton = true
                    }
                }
            }
    }
}

#Preview {
    SplashView(isActive: .constant(false))
}
