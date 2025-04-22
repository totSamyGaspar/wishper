//
//  TarotReadingViewModel.swift
//  TarotApp
//
//  Created by Edward Gasparian on 07.04.2025.
//

import Foundation
import SwiftUI

class TarotReadingViewModel: ObservableObject {
    @Published var drawnCards: [TarotCard] = []
    
    @AppStorage("language") var language: String = "ua" {
        didSet {
            loadDeck()
            drawnCards = []
        }
    }
    
    private var deck: [TarotCard] = []
    init() {
        loadDeck()
    }
    
    func loadDeck() {
        deck = TarotDeck.loadFromMultilangJSON(language: language)
    }
    
    func drawCards(count: Int) {
        drawnCards = deck.shuffled().prefix(count).map { card in
            TarotCard(
                name: card.name,
                uprightMeaning: card.uprightMeaning,
                reversedMeaning: card.reversedMeaning,
                imageName: card.imageName,
                isReversed: Bool.random()
            )
        }
    }
    
    func saveReading(question: String, spreadType: TarotSpreadType) {
        var history = TarotHistoryStorage.shared.load()
        let newItem = TarotReadingHistoryItem(
            date: Date(),
            question: question,
            spreadType: spreadType,
            cards: drawnCards
        )
        history.insert(newItem, at: 0)
        TarotHistoryStorage.shared.save(history)
        
        print("✅ Расклад сохранён. Всего записей: \(history.count)")
    }
}
