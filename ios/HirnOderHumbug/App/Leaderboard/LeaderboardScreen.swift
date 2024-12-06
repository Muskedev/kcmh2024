//
//  LeaderboardScreen.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 03.12.24.
//

import SwiftUI

struct LeaderboardScreen: View {
    
    @Environment(\.appViewModel) private var appViewModel
    
    var body: some View {
        ZStack {
            BHMesh()
         
            VStack(spacing: 30.0) {
                BrightonHeader(head: "Leaderboard", subhead: "Hier regiert die Crème de la Cringe – oder die Champions, je nach Perspektive.")
                    .padding()
                
                ScrollView {
                    VStack(spacing: 10) {
                        Text("Deine Platzierung")
                            .font(.leaderboardHead)
                            .foregroundStyle(.white)
                        
                        LeaderboardRow(entry: appViewModel.userEntryReally)
                    }
                    .padding()
                    
                    Text("Top 5")
                        .font(.leaderboardHead)
                        .foregroundStyle(.white)
                    
                    LazyVStack(spacing: 10.0) {
                        ForEach(appViewModel.reallyLeaderList, id: \.name) { entry in
                            LeaderboardRow(entry: entry)
                                .padding(.horizontal, 20)
                        }
                    }
                    
                    Spacer()
                }
                .safeAreaInset(edge: .bottom, content: {
                    Color.clear.frame(height: 80)
                })
                .scrollIndicators(.hidden)
            }
        }
        .onAppear {
            appViewModel.fetchLeaders()
        }
    }
}

private struct LeaderboardRow: View {
    
    let entry: ScoreboardUser
    
    var body: some View {
        ZStack {
            HStack {
                ZStack {
                    Image(systemName: entry.rank <= 5 ? "seal.fill": "app.fill")
                        .font(.system(size: 26))
                        .foregroundStyle(badgeColor(entry.rank))
                    
                    Text("\(entry.rank)")
                        .font(.aboutUsName)
                        .foregroundColor(.black)
                }
                
                Text(entry.name)
                    .font(.aboutUsName)
                    
                Spacer()
                
                Text("\(entry.score)")
                    .font(.aboutUsName)
            }
            .multilineTextAlignment(.leading)
            .padding()
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 20.0)
                        .fill(.aboutUsBackground)
                    
                    if entry.name == KeychainHelper.shared.userName {
                        RoundedRectangle(cornerRadius: 20.0)
                          .glow(
                            fill: .angularGradient(
                                stops: [
                                  .init(color: .backgroundOne, location: 0.0),
                                  .init(color: .backgroundTwo, location: 0.2),
                                  .init(color: .positive, location: 0.4),
                                  .init(color: .backgroundOne, location: 0.5),
                                  .init(color: .backgroundTwo, location: 0.7),
                                  .init(color: .positive, location: 0.9),
                                  .init(color: .backgroundOne, location: 1.0),
                                ],
                                center: .center,
                                startAngle: Angle(radians: .zero),
                                endAngle: Angle(radians: .pi * 2)
                              ),
                            lineWidth: 5.0
                          )
                    }
                }
            )
        }
    }
    
    private func badgeColor(_ rank: Int) -> Color {
        switch rank {
        case 1: .yellow
        case 2: .orange
        case 3: .gray
        default: .backgroundTwo.opacity(0.4)
        }
    }
}
