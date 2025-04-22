//
//  MultilangTarotCard.swift
//  TarotApp
//
//  Created by Edward Gasparian on 08.04.2025.
//

import Foundation

struct MultilangTarotCard: Decodable {
    let name: [String: String]
    let uprightMeaning: [String: String]
    let reversedMeaning: [String: String]
    let imageName: String
}
