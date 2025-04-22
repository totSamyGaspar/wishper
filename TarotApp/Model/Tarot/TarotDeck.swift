//
//  TarotDeck.swift
//  TarotApp
//
//  Created by Edward Gasparian on 07.04.2025.
//
import Foundation

struct TarotDeck {
    
    static func loadFromMultilangJSON(language: String) -> [TarotCard] {
        guard let url = Bundle.main.url(forResource: "tarot_cards_full_real_meanings1_fixed", withExtension: "json") else {
            print("❌ JSON-файл не найден в Bundle")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let rawCards = try decoder.decode([MultilangTarotCard].self, from: data)
            
            let cards = rawCards.map { card in
                TarotCard(
                    name: card.name,
                    uprightMeaning: card.uprightMeaning,
                    reversedMeaning: card.reversedMeaning,
                    imageName: card.imageName,
                    isReversed: false
                )
            }
            
            return cards
        } catch {
            print("❌ Ошибка при загрузке JSON: \(error.localizedDescription)")
            return []
        }
    }
}
