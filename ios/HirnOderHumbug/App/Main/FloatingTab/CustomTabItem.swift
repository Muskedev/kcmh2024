//
//  CustomTabItem.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 03.12.24.
//

import SwiftUI

enum CustomTabItem: Int, CaseIterable {
    
    case really
    case thinkSolve
    case leaderboard
    case history
    case about
    
    var caption: String {
        switch self {
        case .really: GameMode.really.name
        case .thinkSolve: GameMode.thinkSolve.name
        case .leaderboard: "Leaderboard "
        case .history: "Question History"
        case .about: "About"
        }
    }
    
    var icon: String {
        switch self {
        case .really: "checkmark.circle.badge.xmark"
        case .thinkSolve: "questionmark.bubble"
        case .leaderboard: "trophy"
        case .history: "questionmark.text.page"
        case .about: "info.circle"
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
