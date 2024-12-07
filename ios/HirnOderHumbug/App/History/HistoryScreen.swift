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
        
        @Bindable var appViewModel = appViewModel
        
        ZStack {
            BHMesh()
            
            VStack(spacing: 20.0) {
                BrightonHeader(head: "Question History", subhead: "Die Gedanken von gestern, die Lacher von heute – deine persönliche Reise durch die kuriosesten Fragen aller Zeiten!")
                
                SegmentedControl(
                    tabs: TTSegment.history,
                    activeTab: $appViewModel.historyCurrentMode,
                    height: 35,
                    font: .segmentHistory,
                    activeTint: .white,
                    inActiveTint: .white.opacity(0.3)
                ) { size in
                    Rectangle()
                        .fill(.dontknow.opacity(0.8))
                        .frame(height: 4)
                        .padding(.horizontal, 10)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
                
                if appViewModel.historyLoading {
                    Image(systemName: "ellipsis")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.wiggle.up.byLayer, options: .repeat(.continuous))
                        .padding(.top, 80)
                    
                    Spacer()
                } else if appViewModel.historyReallyQuestions.isEmpty {
                    Text("Keine History vorhanden")
                        .font(.buttonQuiz)
                        .foregroundStyle(.white)
                        .padding(.top, 80)
                        .padding(.horizontal, 30.0)
                    
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack {
                            HistoryStats()
                            ForEach(appViewModel.history, id: \.id) { question in
                                if appViewModel.historyCurrentMode.gameMode == .really {
                                    HistoryReallyRow(question: question)
                                }
                            }
                        }
                    }
                    .safeAreaInset(edge: .bottom, content: {
                        Color.clear.frame(height: 80)
                    })
                    .scrollIndicators(.hidden)
                }
            }
            .padding()
        }
        .onAppear{
            appViewModel.switchMode(appViewModel.historyCurrentMode.gameMode)
        }
    }
}
