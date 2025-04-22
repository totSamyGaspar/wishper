//
//  SpreadBadgeView.swift
//  TarotApp
//
//  Created by Edward Gasparian on 07.04.2025.
//

import SwiftUI

struct SpreadBadgeView: View {
    let spread: TarotSpreadType
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: spread.icon)
                .foregroundColor(spread.color)
            Text(spread.rawValue)
                .foregroundColor(.pureGold)
        }
        .frame(width: 150, height: 25)
        .font(.subheadline)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(spread.color.opacity(0.15))
        .clipShape(Capsule())
    }
}

#Preview {
    VStack(spacing: 10) {
        SpreadBadgeView(spread: .oneCard)
        SpreadBadgeView(spread: .threeCards)
        SpreadBadgeView(spread: .love)
        SpreadBadgeView(spread: .career)
    }
    .padding()
}
