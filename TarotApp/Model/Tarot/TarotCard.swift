//
//  TarotCard.swift
//  TarotApp
//
//  Created by Edward Gasparian on 07.04.2025.
//

import Foundation

struct TarotCard: Identifiable, Codable {
    var id = UUID()
    let name: [String: String]
    let uprightMeaning: [String: String]
    let reversedMeaning: [String: String]
    let imageName: String
    var isReversed: Bool = false
    
    
    enum CodingKeys: String, CodingKey {
        case name, uprightMeaning, reversedMeaning, imageName, isReversed
    }
    init(name: [String: String],
         uprightMeaning: [String: String],
         reversedMeaning: [String: String],
         imageName: String,
         isReversed: Bool = false) {
        self.name = name
        self.uprightMeaning = uprightMeaning
        self.reversedMeaning = reversedMeaning
        self.imageName = imageName
        self.isReversed = isReversed
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode([String: String].self, forKey: .name)
        self.uprightMeaning = try container.decode([String: String].self, forKey: .uprightMeaning)
        self.reversedMeaning = try container.decode([String: String].self, forKey: .reversedMeaning)
        self.imageName = try container.decode(String.self, forKey: .imageName)
        self.isReversed = try container.decodeIfPresent(Bool.self, forKey: .isReversed) ?? false
    }
    
}
