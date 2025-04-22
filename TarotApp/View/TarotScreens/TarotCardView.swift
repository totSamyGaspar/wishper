//
//  TarotCardView.swift
//  TarotApp
//
//  Created by Edward Gasparian on 07.04.2025.
//

import SwiftUI

struct TarotCardView: View {
    @AppStorage("language") var language: String = "ua"
    
    let card: TarotCard
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                cardImage
                cardTitle
            }
            .foregroundColor(.pureGold)
        }
    }
        
    
    private var cardName: String {
        card.name[language] ?? card.name["ua"] ?? "❓"
    }
    
    private var cardMeaning: String {
        if card.isReversed {
            return card.reversedMeaning[language] ?? card.reversedMeaning["en"] ?? ""
        } else {
            return card.uprightMeaning[language] ?? card.uprightMeaning["en"] ?? ""
        }
    }
    
    private var cardImage: some View {
        Image(card.imageName)
            .resizable()
            .frame(width: 100, height: 150)
            .rotationEffect(card.isReversed ? Angle(degrees: 180) : .zero)
            .cornerRadius(8)
            .shadow(radius: 4)
            .background {
                Rectangle()
                    .frame(width: 110, height: 160)
                    .clipShape(.rect(cornerRadius: 12))
            }
    }
    
    private var cardTitle: some View {
        Text(cardName)
            .font(.headline)
            .lineLimit(1)
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.5)
    }
}

#Preview {
    TarotCardView(language: "ua", card: TarotCard(
        name: ["en": "The Tower", "ru": "Башня", "ua": "Вежа"],
        uprightMeaning: ["en": "Sudden change", "ru": "Внезапные перемены", "ua": "Раптова зміна"],
        reversedMeaning: ["en": "Avoidance", "ru": "Избежание перемен", "ua": "Уникнення змін"],
        imageName: "16-TheTower",
        isReversed: true
    ))
}
