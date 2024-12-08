//
//  HistoryStats.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 07.12.24.
//

import SwiftUI

struct HistoryStats: View {
    
    @Environment(\.appViewModel) private var appViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Deine Statistik")
                .font(.leaderboardHead)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
            
            RoundedRectangle(cornerRadius: 3)
                .fill(.white.opacity(0.3))
                .frame(height: 3)
            
            HStack {
                VStack {
                    Text("Fragen")
                        .font(.statHeader)
                    Text("\(appViewModel.historyReallyQuestions.count)")
                        .font(.statValue)
                        .contentTransition(.numericText())
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("Richtige")
                        .font(.statHeader)
                    Text("\(appViewModel.reallyHistoryCorrect.string(0)) %")
                        .font(.statValue)
                        .contentTransition(.numericText())
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("Streak")
                        .font(.statHeader)
                    Text("\(appViewModel.reallyHistoryStreak)")
                        .font(.statValue)
                        .contentTransition(.numericText())
                }
                .frame(maxWidth: .infinity)
            }
            .foregroundStyle(.white)
            .padding(.vertical, 10.0)
            
            RoundedRectangle(cornerRadius: 3)
                .fill(.white.opacity(0.3))
                .frame(height: 2)
        }
        .animation(.easeInOut, value: appViewModel.historyReallyQuestions)
    }
}
