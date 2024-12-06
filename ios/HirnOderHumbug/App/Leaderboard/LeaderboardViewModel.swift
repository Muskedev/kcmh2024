//
//  LeaderboardViewModel.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 06.12.24.
//

import Foundation

@Observable
class LeaderboardViewModel {
    
    private(set) var entries: [ScoreboardUser] = .init()
    
    var entryForList: [ScoreboardUser] {
        if entries.count > 5 {
            return Array(entries.prefix(upTo: 5))
        } else {
            return entries
        }
    }
    
    var userEntry: ScoreboardUser {
        let name = KeychainHelper.shared.userName ?? ""
        return entries.first { $0.name == name } ?? .init(name: name, score: 0, rank: entries.count + 1)
    }
    
    func fetchLeaderboard() {
        entries = []
        
        Task {
            let result = await BHController.request(.getLeaderboard, expected: Scoreboard.self)
            switch result {
            case .success(let scoreboard):
                self.entries = scoreboard.entries.sorted(by: { $0.rank < $1.rank })
                
            case .failure(let error):
                print("Error fetching Leaderboard: \(error)")
            }
        }
    }
}
