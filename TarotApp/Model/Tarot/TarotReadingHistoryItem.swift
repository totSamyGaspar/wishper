//
//  TarotReadingHistoryItem.swift
//  TarotApp
//
//  Created by Edward Gasparian on 07.04.2025.
//

import Foundation

struct TarotReadingHistoryItem: Codable, Identifiable {

    var id = UUID()
    let date: Date
    let question: String
    let spreadType: TarotSpreadType
    let cards: [TarotCard]
    
    
}
