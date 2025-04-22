//
//  HomeView.swift
//  TarotApp
//
//  Created by Edward Gasparian on 07.04.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedSpread: TarotSpreadType = .threeCards
    @State private var goToReading = false
    
    @AppStorage("language") var language: String = "ua" 
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geo in
                ZStack {
                    MagicParticlesView(width: geo.size.width, height: geo.size.height)
                    VStack {
                        Text(Localized.t(.homeTitle, lang: language))
                            .foregroundColor(Color(.pureGold))
                            .shadow(radius: 5)
                            .font(.largeTitle)
                            .bold()
                        
                        Picker("Spread Type", selection: $selectedSpread) {
                            ForEach(TarotSpreadType.allCases, id: \.self) { spread in
                                Text(spread.localizedTitlePiker(lang: language))
                                    .tag(spread)
                                    .foregroundColor(.pureGold)
                            }
                        }
                        .padding(.top, 170)
                        .pickerStyle(.wheel)
                        .accentColor(Color(.pureGold))
                        
                        Button {
                            goToReading.toggle()
                            SoundManager.shared.playEffect(named: "button_click")
                        } label: {
                            HStack {
                                Image(systemName: "sparkles")
                                Text(Localized.t(.makeSpread, lang: language))
                                    .font(.title2)
                                    .padding(.horizontal)
                                Image(systemName: "sparkles")
                                    .scaleEffect(x: -1)
                                
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.pureGold)
                            .foregroundColor(.misteryBlue)
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                        .navigationDestination(isPresented: $goToReading) {
                            TarotReadingView(spreadType: selectedSpread)
                        }
                        .padding(.top, 100)
                        NavigationLink(destination: HistoryView()) {
                            Text(Localized.t(.history, lang: language))
                                .foregroundColor(.pureGold)
                                .padding()
                        }
                    }
                    .navigationBarItems(trailing: NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear.circle.fill")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.pureGold)
                            .background(Color.misteryBlue)
                            .clipShape(Circle())
                            .padding()
                    })
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            LogOutButton()
                        }
                    }
                }
                .background(Image("background")
                    .resizable()
                    .ignoresSafeArea())
                
            }
        }
        .preferredColorScheme(.dark)
        .tint(.pureGold)
        .shadow(radius: 5)
    }
}

#Preview {
    HomeView()
}
