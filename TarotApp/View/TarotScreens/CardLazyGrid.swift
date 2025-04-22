//
//  CardLazyGrid.swift
//  TarotApp
//
//  Created by Edward Gasparian on 16.04.2025.
//

import SwiftUI

struct CardLazyGrid: View {
    let drawnCards: [TarotCard]
    let animateCards: Bool
    let onCardSelected: (TarotCard) -> Void
    
    var body: some View {
        
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: min(drawnCards.count, 3))
        
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(Array(drawnCards.enumerated()), id: \.element.id) { index, card in
                Button {
                    onCardSelected(card)
                    SoundManager.shared.playEffect(named: "button_click")
                } label: {
                    TarotCardView(card: card)
                        .frame(maxWidth: .infinity)
                        .offset(y: animateCards ? 0 : -100)
                        .opacity(animateCards ? 1 : 0)
                        .onAppear {
                            guard animateCards else { return }
                            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.2) {
                                SoundManager.shared.playEffect(named: "flip_card")
                            }
                        }
                        .animation(
                            .easeOut(duration: 0.6).delay(Double(index) * 0.2),
                            value: animateCards
                        )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

