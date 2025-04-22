//
//  QuestionInputView.swift
//  TarotApp
//
//  Created by Edward Gasparian on 16.04.2025.
//

import SwiftUI

struct QuestionInputView: View {
    @Binding var userQuestion: String
    var body: some View {
        TextField("Enter your question...", text: $userQuestion, axis: .vertical)
            .font(.system(.title3, design: .serif))
            .italic()
            .padding()
            .textFieldStyle(.roundedBorder)
            .background(Color.misteryBlue.opacity(0.8))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.pureGold.opacity(0.9), lineWidth: 1)
            )
            .lineLimit(1...6)
            .foregroundColor(.pureGold)
    }
}

#Preview {
    QuestionInputView(userQuestion: .constant("Should I change my job?"))
        .background(Color.black)
}
