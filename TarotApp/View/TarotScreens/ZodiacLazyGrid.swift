//
//  ZodiacLazyGrid.swift
//  TarotApp
//
//  Created by Edward Gasparian on 16.04.2025.
//

import SwiftUI

struct ZodiacLazyGrid: View {
    @Binding var selectedZodiac: ZodiacList?
    var language: String
    
    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: min(ZodiacList.allCases.count, 3))
        
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(Array(ZodiacList.allCases.enumerated()), id: \.element.id) { index, zodiac in
                
                Button {
                    selectedZodiac = zodiac
                    SoundManager.shared.playEffect(named: "button_click")
                } label: {
                    VStack {
                        Image(zodiac.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(selectedZodiac == zodiac ? Color.pureGold : Color.pureGold.opacity(0.5),
                                            lineWidth: selectedZodiac == zodiac ? 2 : 1)
                            )
                        Text(zodiac.localizedZodiacPicker(lang: language))
                            .font(.caption)
                            .foregroundColor(.pureGold)
                            .minimumScaleFactor(0.5)
                            .background {
                                Rectangle()
                                    .clipShape(.rect(cornerRadius: 8))
                                    .foregroundColor(.misteryBlue)
                                    .frame(width: 70)
                            }
                            .padding(.horizontal)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    ZodiacLazyGrid(selectedZodiac: .constant(nil), language: "ua")
}
