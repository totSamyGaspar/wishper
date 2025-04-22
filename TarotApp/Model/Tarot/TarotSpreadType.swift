//
//  TarotSpreadType.swift
//  TarotApp
//
//  Created by Edward Gasparian on 07.04.2025.
//

import Foundation
import SwiftUI

enum TarotSpreadType: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }
    
    case oneCard = "One Card"
    case threeCards = "Three Cards"
    case love = "Love"
    case career = "Career Path"
    
    var numbOfCards: Int {
        switch self {
        case .oneCard:
            return 1
        case .threeCards:
            return 3
        case .love, .career:
            return 5
        }
    }
    //MARK: - Localization
    func localizedTitlePiker(lang: String) -> String {
        
        switch (self, lang) {
            
        case (.oneCard, "ua"): return "Одна карта"
        case (.oneCard, "en"): return "One Card"
        case (.oneCard, "ru"): return "Одина карта"
        
        case (.threeCards, "ua"): return "Три карти"
        case (.threeCards, "en"): return "Three Cards"
        case (.threeCards, "ru"): return "Три карты"
          
        case (.love, "ua"): return "Кохання"
        case (.love, "en"): return "Love"
        case (.love, "ua"): return "Любовь"
        
        case (.career, "ua"): return "Кар'єра"
        case (.career, "en"): return "Career"
        case (.career, "ru"): return "Карьера"
            
        default:
            return "Unknown"
        }
    }
}

extension TarotSpreadType {
    var icon: String {
        switch self {
        case .oneCard: return "suit.spade.fill"
        case .threeCards: return "circle.grid.3x3"
        case .love: return "heart.fill"
        case .career: return "briefcase.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .oneCard: return .blue
        case .threeCards: return .purple
        case .love: return .pink
        case .career: return .orange
        }
    }
}
