//
//  HistoryView.swift
//  TarotApp
//
//  Created by Edward Gasparian on 07.04.2025.
//

import SwiftUI

struct HistoryView: View {
    @State private var history: [TarotReadingHistoryItem] = []
    @State private var showDeleteAllAlert = false
    @State private var deleteIndexSet: IndexSet?
    @State private var selectedFilter: TarotSpreadType? = nil
    @AppStorage("language") var language: String = "ua"
    
    var filteredHistory: [TarotReadingHistoryItem] {
        if let filter = selectedFilter {
            return history.filter { $0.spreadType == filter }
        } else {
            return history
        }
    }
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            filterButton(title: "All", isSelected: selectedFilter == nil) {
                                withAnimation {
                                    selectedFilter = nil
                                }
                            }
                            
                            ForEach(TarotSpreadType.allCases) { type in
                                filterButton(title: type.rawValue, isSelected: selectedFilter == type) {
                                    withAnimation {
                                        selectedFilter = type
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .background(Color("mistery_blue"))
                
                if filteredHistory.isEmpty {
                    VStack(spacing: 12) {
                        Text(Localized.t(.history, lang: language))
                            .font(.title2)
                        Image(systemName: "tray")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            
                    }
                    .foregroundColor(.pureGold)
                    .padding(.top, 50)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(filteredHistory) { item in
                                HistoryCardView(item: item)
                                    .padding(.horizontal)
                                    .transition(.opacity)
                            }
                            .onDelete { indexSet in
                                deleteIndexSet = indexSet
                            }
                        }
                        .padding(.top)
                    }
                }
                
                if !history.isEmpty {
                    Button(Localized.t(.deleteAll, lang: language)) {
                        showDeleteAllAlert = true
                    }
                    .foregroundColor(.pureGold)
                    .padding(.bottom)
                }
            }
            .navigationBarItems(trailing: EditButton())
            
            .onAppear {
                SoundManager.shared.playEffect(named: "button_click")
                history = TarotHistoryStorage.shared.load()
            }
            .alert("Delete all history?", isPresented: $showDeleteAllAlert) {
                Button("Delete", role: .destructive) {
                    history.removeAll()
                    TarotHistoryStorage.shared.save(history)
                }
                Button("Cancel", role: .cancel) { }
            }
            .alert("Delete this reading?", isPresented: Binding(
                get: { deleteIndexSet != nil },
                set: { if !$0 { deleteIndexSet = nil } }
            )) {
                Button("Delete", role: .destructive) {
                    if let indexSet = deleteIndexSet {
                        history.remove(atOffsets: indexSet)
                        TarotHistoryStorage.shared.save(history)
                        deleteIndexSet = nil
                    }
                }
                Button("Cancel", role: .cancel) {
                    deleteIndexSet = nil
                }
            }
        }
    }
    
    private func filterButton(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.pureGold.opacity(1) : Color.pureGold.opacity(0.6))
                .foregroundColor(.misteryBlue)
                .cornerRadius(10)
        }
    }
}
#Preview {
        HistoryView()
}
