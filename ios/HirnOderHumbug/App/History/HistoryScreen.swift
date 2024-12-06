//
//  HistoryScreen.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 03.12.24.
//

import SwiftUI

struct HistoryScreen: View {
    
    @Environment(\.appViewModel) private var appViewModel
    
    var body: some View {
        ZStack {
            BHMesh()
            
            VStack(spacing: 20.0) {
                BrightonHeader(head: "Question History", subhead: "Die Gedanken von gestern, die Lacher von heute – deine persönliche Reise durch die kuriosesten Fragen aller Zeiten!")
                
                HStack {
                    ForEach(GameMode.allCases, id: \.rawValue) { mode in
                        HStack {
                            Image(systemName: mode.icon)
                                .font(.historyButtonIcon)
                            Text(mode.name)
                                .font(.historyButtonText)
                        }
                        .foregroundStyle(appViewModel.historyCurrentMode == mode ? .white: .backgroundTwo)
                        .frame(maxWidth: .infinity, minHeight: 50.0, maxHeight: 50.0)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(appViewModel.historyCurrentMode == mode ? .backgroundTwo: .white)
                        )
                        .button {
                            appViewModel.switchMode(mode)
                        }
                    }
                }
                
                ScrollView {
                    LazyVStack {
                        ForEach(appViewModel.history, id: \.id) { question in
                            if appViewModel.historyCurrentMode == .really {
                                HistoryReallyRow(question: question)
                            }
                        }
                    }
                }
                .safeAreaInset(edge: .bottom, content: {
                    Color.clear.frame(height: 80) // Adds a safe area inset of 50 points at the bottom
                })
                .scrollIndicators(.hidden)
                .ignoresSafeArea(.container, edges: .bottom)
                
                Spacer()
            }
            .padding()
        }
        .onAppear{
            appViewModel.switchMode(appViewModel.historyCurrentMode)
        }
    }
}
