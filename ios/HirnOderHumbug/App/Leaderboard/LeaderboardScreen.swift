//
//  LeaderboardScreen.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 03.12.24.
//

import SwiftUI

struct LeaderboardScreen: View {
    
    var body: some View {
        ZStack {
            BHMesh()
         
            VStack {
                BrightonHeader(head: "Leaderboard", subhead: "Hier regiert die Crème de la Cringe – oder die Champions, je nach Perspektive.")
                
                ScrollView {
                    LazyVStack {
                        LeaderboardRow(name: "Person", rank: 1)
                        LeaderboardRow(name: "Person", rank: 2)
                        LeaderboardRow(name: "Person", rank: 3)
                        LeaderboardRow(name: "Person", rank: 4)
                    }
                }
                .safeAreaInset(edge: .bottom, content: {
                    Color.clear.frame(height: 80)
                })
                .scrollIndicators(.hidden)
                
                Spacer()
            }
            .padding()
        }
    }
}

private struct LeaderboardRow: View {
    
    let name: String
    let rank: Int
    
    var body: some View {
        ZStack {
            HStack {
                switch rank {
                case 1:
                    Image(systemName: "trophy")
                        .foregroundStyle(.yellow)
                        .bold()
                case 2:
                    Image(systemName: "trophy")
                        .foregroundStyle(.gray)
                        .bold()
                case 3:
                    Image(systemName: "trophy")
                        .foregroundStyle(.orange)
                        .bold()
                default:
                    EmptyView()
                }
                Text("\(rank)")
                Text(name)
                    .font(Font.aboutUsName)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .multilineTextAlignment(.leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20.0)
                    .fill(.aboutUsBackground)
            )
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    LeaderboardScreen()
}
