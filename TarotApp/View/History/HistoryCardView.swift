//
//  HistoryCardView.swift
//  TarotApp
//
//  Created by Edward Gasparian on 13.04.2025.
//

import SwiftUI

struct HistoryCardView: View {
    let item: TarotReadingHistoryItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                SpreadBadgeView(spread: item.spreadType)
                
                Spacer()
                Text(item.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            if !item.question.isEmpty {
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "person.fill.questionmark")
                    Text(item.question)
                        .font(.system(.footnote, design: .serif))
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.5)
                        .italic()
                }
                .foregroundColor(.pureGold)
                .padding()
                .background(Color.misteryBlue.opacity(0.3))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.pureGold.opacity(0.6), lineWidth: 1)
                )
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(item.cards) { card in
                        VStack(spacing: 5) {
                            Image(card.imageName)
                                .resizable()
                                .frame(width: 60, height: 90)
                                .rotationEffect(card.isReversed ? .degrees(180) : .zero)
                                .background{
                                    Rectangle()
                                        .frame(width: 70, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                        .foregroundColor(.pureGold)
                                        .shadow(radius: 5)
                                }
                                .padding(.bottom)
                            CardInfoView(card: card)
                                .frame(width: 100)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.pureGold)
                                .shadow(radius: 3)
                        }
                    }
                }
                .padding(.top)
            }
        }
        .padding()
        .background(Color.misteryBlue.opacity(0.5))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.pureGold.opacity(0.5), lineWidth: 1)
        )
        .shadow(radius: 4)
    }
}
#Preview {
    HistoryCardView(item: TarotReadingHistoryItem(
        date: Date(), question: "Моє запитання", spreadType: .love,
        cards: [
            TarotCard(
                name: ["en": "The Fool", "ua": "Дурень"],
                uprightMeaning: ["en": "New beginnings", "ua": "Новий початок"],
                reversedMeaning: ["en": "Naivety", "ua": "Наївність"],
                imageName: "00-TheFool",
                isReversed: false
            ),
            TarotCard(
                name: ["en": "The Tower", "ua": "Вежа"],
                uprightMeaning: ["en": "Sudden change", "ua": "Раптова зміна"],
                reversedMeaning: ["en": "Avoidance", "ua": "Уникнення змін"],
                imageName: "16-TheTower",
                isReversed: true
            ),
            TarotCard(
                name: ["en": "The Lovers", "ua": "Коханці"],
                uprightMeaning: ["en": "Harmony", "ua": "Гармонія"],
                reversedMeaning: ["en": "Imbalance", "ua": "Дисгармонія"],
                imageName: "06-TheLovers",
                isReversed: false
            )
        ]
    ))
    .padding()
    .background(Color("background"))
}
