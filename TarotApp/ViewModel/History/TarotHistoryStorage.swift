//
//  TarotHistoryStorage.swift
//  TarotApp
//
//  Created by Edward Gasparian on 07.04.2025.
//

import Foundation

class TarotHistoryStorage {
    static let shared = TarotHistoryStorage()
    private let key = "tarot_reading_history"
    
    func load() -> [TarotReadingHistoryItem] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([TarotReadingHistoryItem].self, from: data) else {
            return []
        }
        return decoded
    }
    
    func save(_ history: [TarotReadingHistoryItem]) {
        if let encoded = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
