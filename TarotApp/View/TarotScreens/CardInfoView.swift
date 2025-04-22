//
//  CardInfoView.swift
//  TarotApp
//
//  Created by Edward Gasparian on 07.04.2025.
//

import SwiftUI

struct CardInfoView: View {
    @AppStorage("language") var language: String = "ua"
    
    let card: TarotCard
    
    var body: some View {
        VStack {
            HStack(spacing: 6) {
                Image(systemName: card.isReversed ? "arrow.uturn.down" : "arrow.up")
                    .foregroundColor(card.isReversed ? .red : .green)
                Text(card.name[language] ?? card.name["ua"] ?? "❓")
                    .font(.caption)
                    .bold()
                    .multilineTextAlignment(.center)
                
            }
        }
        Text(meaningText()) // Використовуємо функцію для спрощення
            .font(.caption2)
            .italic()
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.5)
        Spacer()
    }
    
    private func meaningText() -> String {
        if card.isReversed {
            return card.reversedMeaning[language] ?? card.reversedMeaning["en"] ?? ""
        } else {
            return card.uprightMeaning[language] ?? card.uprightMeaning["en"] ?? ""
        }
    }
}

#Preview {
    VStack(spacing: 10) {
        CardInfoView(
            card: TarotCard(
                name: ["en": "The Fool", "ru": "Дурак", "ua": "Дурень"],
                uprightMeaning: ["en": "New beginnings", "ru": "Новые начала", "ua": "Нові починання"],
                reversedMeaning: ["en": "Foolishness", "ru": "Глупость", "ua": "Дурість"],
                imageName: "00-TheFool",
                isReversed: false
            )
        )
        
        CardInfoView(
            card: TarotCard(
                name: ["en": "The Tower", "ru": "Башня", "ua": "Вежа"],
                uprightMeaning: ["en": "Sudden change", "ru": "Внезапные перемены", "ua": "Раптова зміна"],
                reversedMeaning: ["en": "Avoidance", "ru": "Избежание перемен", "ua": "Уникнення змін"],
                imageName: "16-TheTower",
                isReversed: true
            )
        )
    }
    .padding()
}
