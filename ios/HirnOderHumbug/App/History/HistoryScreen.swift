//
//  HistoryScreen.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 03.12.24.
//

import SwiftUI

struct HistoryScreen: View {
    
    @State private var currentActive: GameMode = .thinkSolve
    
    var body: some View {
        ZStack {
            BHMesh()
            
            VStack(spacing: 20.0) {
                BrightonHeader(head: "Question History", subhead: "Die Gedanken von gestern, die Lacher von heute – deine persönliche Reise durch die kuriosesten Fragen aller Zeiten!")
                
                HStack {
                    ForEach(GameMode.allCases, id: \.rawValue) { mode in
                        Image(systemName: mode.icon)
                            .font(.historyInfo)
                            .foregroundStyle(currentActive == mode ? .white: .backgroundTwo)
                            .frame(maxWidth: .infinity, minHeight: 50.0, maxHeight: 50.0)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(currentActive == mode ? .backgroundTwo: .white)
                            )
                            .button {
                                currentActive = mode
                            }
                    }
                }
                
                ScrollView {
                    LazyVStack {
                        HistoryTSRow()
                        HistoryTSRow()
                        HistoryTSRow()
                        HistoryTSRow(wasCorrect: false)
                        HistoryTSRow(wasCorrect: false)
                        HistoryTSRow()
                        HistoryTSRow(wasCorrect: false)
                    }
                }
                .safeAreaInset(edge: .bottom, content: {
                    Color.clear.frame(height: 80) // Adds a safe area inset of 50 points at the bottom
                })
                .scrollIndicators(.hidden)
                
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }
}
