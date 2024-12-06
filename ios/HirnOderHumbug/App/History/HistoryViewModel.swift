//
//  HistoryViewModel.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 06.12.24.
//

import Foundation

@Observable
class HistoryViewModel {
    
    private(set) var reallyQuestions: [FunfactsQuestion] = .init()
    var currentActive: GameMode = .really
    
    func switchHistory(_ mode: GameMode, fetch: Bool) {
        currentActive = mode
        switch mode {
        case .really: fetchReallyQuestions(fetch)
        case .thinkSolve: return
        }
    }
    
    private func fetchReallyQuestions(_ fetch: Bool) {
        guard reallyQuestions.isEmpty || fetch, let userID = KeychainHelper.shared.userId else { return }
        reallyQuestions = []
        Task {
            let result = await BHController.request(.getFinishedRounds(userID), expected: FinishedFunfactRounds.self)
            switch result {
            case .success(let history):
                for round in history.finishedRounds {
                    self.reallyQuestions.append(contentsOf: round.questions)
                }
            case .failure(let error):
                print("Error on fetching histories: \(error)")
            }
        }
    }
}
