//  TabView.swift
//  HirnOderHumbug
//
//  Created by Nico on 02.12.24.
//  
//

import SwiftUI
import SwiftChameleon

private enum CustomTabItem: Int, CaseIterable {
    
    case really
    case thinkSolve
    case leaderboard
    case history
    case about
    
    var caption: String {
        switch self {
        case .really: GameMode.really.name
        case .thinkSolve: GameMode.thinkSolve.name
        case .leaderboard: "Leaderboard"
        case .history: "Question History"
        case .about: "About"
        }
    }
    
    var icon: String {
        switch self {
        case .really: "checkmark.circle.badge.xmark"
        case .thinkSolve: "questionmark.bubble"
        case .leaderboard: "trophy"
        case .history: "questionmark.text.page.fill"
        case .about: "info.bubble"
        }
    }
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .really: ModeExplanation(mode: .really)
        case .thinkSolve: ModeExplanation(mode: .thinkSolve)
        case .leaderboard: LeaderboardScreen()
        case .history: HistoryScreen()
        case .about: AboutScreen()
        }
    }
}

struct CustomTabView: View {
    
    @State private var selectedTab: CustomTabItem = CustomTabItem.really
    
    var body: some View {
        ZStack {
            selectedTab.view
            
            VStack {
                Spacer()
                HStack {
                    ForEach(CustomTabItem.allCases, id: \.self) { tabItem in
                        CTabItem(tabItem: tabItem, isActive: selectedTab == tabItem)
                            .button {
                                selectedTab = tabItem
                            }
                    }
                }
                .padding(6)
                .frame(height: 70)
                .background(.white)
                .cornerRadius(35)
                .padding(.horizontal, 26)
            }
        }
    }
}

private struct CTabItem: View {

    let tabItem: CustomTabItem
    let isActive: Bool
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tabItem.icon)
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
        }
        .foregroundStyle(isActive ? .white : .gray)
        .frame(maxWidth: isActive ? .infinity : 60)
        .frame(height: 60)
        .if(isActive, { content in
            content
                .background(.backgroundThree.opacity(0.7).gradient)
        })
        .cornerRadius(30)
    }
}

#Preview {
    CustomTabView()
}
