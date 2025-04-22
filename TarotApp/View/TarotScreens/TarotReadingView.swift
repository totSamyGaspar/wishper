//
//  TarotReadingView.swift
//  TarotApp
//
//  Created by Edward Gasparian on 07.04.2025.
//

import SwiftUI

struct TarotReadingView: View {
    @AppStorage("language") var language: String = "ua"
    
    @StateObject private var viewModel = TarotReadingViewModel()
    
    @State private var selectedCard: TarotCard?
    @State private var selectedZodiac: ZodiacList?
    @State private var showDetail = false
    @State private var animateCards = false
    @State private var userQuestion: String = ""
    
    let spreadType: TarotSpreadType
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                MagicParticlesView(width: geo.size.width, height: geo.size.height)
                
                VStack(spacing: 20) {
                    
                    headerTitle
                    
                    Spacer()
                    
                    if viewModel.drawnCards.isEmpty {
                        
                        ZodiacLazyGrid(selectedZodiac: $selectedZodiac, language: language)
                        
                        Spacer()
                        
                        QuestionInputView(userQuestion: $userQuestion)
                        
                        newSpreadButton
                        
                    } else {
                        CardLazyGrid(
                            drawnCards: viewModel.drawnCards,
                            animateCards: animateCards
                        ) {
                            selected in
                            selectedCard = selected
                            showDetail = true
                            userQuestion = ""
                        }
                        Spacer()
                        drawSpreadAgainButton
                    }
                }
                .sheet(isPresented: $showDetail) {
                    if let card = selectedCard {
                        TarotCardDetailView(card: card)
                    }
                }
                
                .padding()
                .onAppear {
                    animateCards = false
                }
            }
            .background(Image("background"))
        }
    }
    
    private var headerTitle: some View {
        Text(spreadType.localizedTitlePiker(lang: "ua"))
            .font(.title)
            .bold()
            .foregroundColor(.pureGold)
            .shadow(radius: 5)
    }
    private var newSpreadButton: some View {
        Button(Localized.t(.newSpread, lang: language)) {
            let count = spreadType.numbOfCards
            viewModel.drawCards(count: count)
            viewModel.saveReading(question: userQuestion, spreadType: spreadType)

            SoundManager.shared.playEffect(named: "button_click")
           
            for i in 0..<count {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.2) {
                    SoundManager.shared.playEffect(named: "flip_card")
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeOut(duration: 0.5)) {
                    animateCards = true
                }
            }
        }
        .padding()
        .background(Color.pureGold)
        .foregroundColor(.misteryBlue)
        .cornerRadius(10)
    }
    
    private var drawSpreadAgainButton: some View {
        Button(Localized.t(.drawAgain, lang: language)) {
            animateCards = false
            SoundManager.shared.playEffect(named: "button_click")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                let count = spreadType.numbOfCards
                viewModel.drawCards(count: count)
                
                for i in 0..<count {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.2) {
                        SoundManager.shared.playEffect(named: "flip_card")
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        animateCards = true
                    }
                }
            }
        }
        .padding()
        .background(Color.pureGold)
        .foregroundColor(.misteryBlue)
        .cornerRadius(10)
        .padding(.bottom, 40)
    }
}

#Preview {
    TarotReadingView(spreadType: .love)
}
