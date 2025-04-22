//
//  TarotCardDetailView.swift
//  TarotApp
//
//  Created by Edward Gasparian on 07.04.2025.
//

import SwiftUI

struct TarotCardDetailView: View {
    @AppStorage("language") var language: String = "ua"
    
    let card: TarotCard
    @State private var flipped = false
    @GestureState private var dragOffset = CGSize.zero
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                MagicParticlesView(width: geo.size.width, height: geo.size.height)
                if flipped {
                    backSide
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                } else {
                    frontSide
                }
            }
            .background(Image("background"))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .cornerRadius(16)
            .shadow(radius: 6)
            .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
            .animation(.easeInOut(duration: 0.6), value: flipped)
            .onTapGesture {
                flipped.toggle()
            }
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation
                    }
                    .onEnded { value in
                        if abs(value.translation.width) > 50 {
                            flipped.toggle()
                        }
                    }
            )
        }
    }
    
    private let cardSize = CGSize(width: 300, height: 400)

    private var frontSide: some View {
        ZStack {
            Image("card_back")
                .resizable()
                .scaledToFit()
                .shadow(color: .pureGold, radius: 5)
                .overlay {
                    Rectangle().fill(Color.misteryBlue).opacity(0.3)
                        .cornerRadius(20)
                }
                
            
            VStack(spacing: 20) {
                Text(card.name[language] ?? card.name["en"] ?? "❓")
                    .font(.title)
                    .bold()
                    .padding(.top)
                    .foregroundColor(.pureGold)
                    .shadow(radius: 10)
                
                Image(card.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 300)
                    .background {
                        Rectangle()
                            .frame(width: 180, height: 310)
                            .foregroundColor(.pureGold)
                            .clipShape(.rect(cornerRadius: 12))
                    }
                    .rotationEffect(card.isReversed ? .degrees(180) : .zero)
                    .shadow(radius: 6)
                
                Text(card.isReversed
                     ? Localized.t(.reversed, lang: language)
                     : Localized.t(.upright, lang: language))
                .font(.headline)
                .foregroundColor(.pureGold)
                .shadow(radius: 10)
                 
                Spacer()
            }
            .frame(width: cardSize.width, height: cardSize.height + 100)
        }
    }
    
    private var backSide: some View {
        ZStack {
            Image("card_back")
                .resizable()
                .scaledToFit()
                .shadow(color: .pureGold, radius: 5)
                .overlay {
                    Rectangle().fill(Color.misteryBlue).opacity(0.5)
                        .cornerRadius(20)
                }
            
            VStack(spacing: 20) {
                Text(Localized.t(.meaningTitle, lang: language))
                    .font(.headline)
                    .bold()
                    .padding(.top)
                    .foregroundColor(.pureGold)
                    .shadow(radius: 10)
                
                Text(cardMeaning)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.pureGold)
                    .padding(.horizontal, 30)
                    .shadow(radius: 10)
                
                
            }
        }
        .frame(width: cardSize.width, height: cardSize.height + 100)
    }
    
    private var cardMeaning: String {
        let value = card.isReversed
        ? card.reversedMeaning[language] ?? card.reversedMeaning["en"]
        : card.uprightMeaning[language] ?? card.uprightMeaning["en"]
        
        return value?.isEmpty == false
        ? value!
        : "—"
    }
}
#Preview {
    TarotCardDetailView(card: TarotCard(
        name: ["en": "The Tower", "ru": "Башня", "ua": "Вежа"],
        uprightMeaning: ["en": "Sudden change", "ru": "Внезапные перемены", "ua": "Раптова зміна"],
        reversedMeaning: ["en": "Avoidance", "ru": "Избежание перемен", "ua": "Уникнення змін"],
        imageName: "16-TheTower",
        isReversed: true
    ))
}
