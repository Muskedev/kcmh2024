//
//  AppViewModel.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 06.12.24.
//

import Foundation

@Observable
class AppViewModel {
    
    // MARK: - Util Environments
    var showAlert: Bool = false
    var noUser: Bool = false
    var newReallyHistory: Bool = false
    var newThinkSolveHistory: Bool = false
    
    // MARK: - User
    
    /// Username to create a user
    var userName: String = ""
    
    /// Check if User was already created
    func checkUserExists() {
        noUser = !KeychainHelper.shared.userExist
        showAlert = noUser
    }
    
    /// API Call Create new User
    func createUser() {
        guard !userName.isEmpty else { return }
        Task {
            let request = await BHController.request(.createUser(userName), expected: UserCreationResponse.self)
            switch request {
            case .success(let user):
                KeychainHelper.shared.userId = user.id
                KeychainHelper.shared.userName = user.name
                self.showAlert = false
                self.noUser = false
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - Really Game
    var reallyRound: FunfactsRound?
    var reallyQuestion: FunfactsQuestion?
    var reallyAnswer: Bool = false
    var reallyCurrentRound: Int = 0
    var reallyScore: Int = 0
    var reallyBasePoints: Int = 10
    var reallyMultiplier: Int = 1
    
    var reallyRounds: Int {
        (reallyRound?.questions.count ?? 1) - 1
    }
    
    var reallyQuestions: [FunfactsQuestion] {
        reallyRound?.questions ?? []
    }
    
    var reallyCorrect: Bool {
        reallyQuestion?.correctAnswer == reallyQuestion?.userAnswer
    }
    
    var reallyLastRound: Bool {
        reallyCurrentRound == reallyRounds
    }
    
    var reallyQuestionExplane: FunfactsQuestion? {
        guard reallyQuestion?.userAnswer != nil else { return nil }
        return reallyQuestion
    }
    
    /// Start new Round
    func newReallyRound() {
        reallyReset()
        fetchReallyRound()
    }
    
    func reallyReset() {
        reallyCurrentRound = 0
        reallyScore = 0
        reallyMultiplier = 1
        reallyRound = nil
        reallyQuestion = nil
        reallyAnswer = false
    }
    
    /// Answer the Question
    func reallyAnswer(_ answer: Bool) {
        reallyAnswer = answer
        reallyQuestion?.userAnswer = answer
        
        if reallyCorrect {
            reallyScore += reallyBasePoints * reallyMultiplier
            reallyMultiplier += 1
        } else {
            reallyMultiplier = 1
        }
        
        guard let reallyQuestion, var reallyRound else { return }
        reallyRound.questions[reallyCurrentRound] = reallyQuestion
        self.reallyRound = reallyRound
    }
    
    /// Set Next Question
    func reallyNextQuestion() {
        guard let reallyRound else { return }
        reallyCurrentRound += 1
        reallyQuestion = reallyRound.questions[reallyCurrentRound]
        reallyAnswer = false
    }
    
    ///API Call fetch new Round
    func fetchReallyRound() {
        guard let userID = KeychainHelper.shared.userId else { return }
        Task {
            let result = await BHController.request(.createFunfactsRound(userID), expected: FunfactsRound.self)
            switch result {
            case .success(let round):
                self.reallyRound = round
                self.reallyQuestion = round.questions[self.reallyCurrentRound]
            case .failure(let error):
                print("Error get funfacts \(error)")
            }
        }
    }
    
    ///API Call end current Round
    func endReallyRound(again: Bool) {
        guard let reallyRound, let userID = KeychainHelper.shared.userId else { return }
        var answeredQuestions: [AnsweredQuestion] = []
        
        for question in reallyRound.questions {
            if let answer = question.userAnswer {
                answeredQuestions.append(.init(id: question.id, userAnswer: answer))
            }
        }
        
        Task {
            let result = await BHController.request(.finishFunfactsRound(userID, reallyRound.id, reallyScore, answeredQuestions), expected: FunfactsRound.self)
            switch result {
            case .success:
                self.newReallyHistory = true
                if again {
                    self.newReallyRound()
                } else {
                    self.reallyReset()
                }
            case .failure(let error):
                print("Error on set score \(error)")
            }
        }
    }
    
    //MARK: - History
    var historyReallyQuestions: [FunfactsQuestion] = .init()
    var historyThinkSolveQuestions: [FunfactsQuestion] = .init()
    var historyCurrentMode: GameMode = .really
    
    var history: [FunfactsQuestion] {
        historyCurrentMode == .really ? historyReallyQuestions : historyThinkSolveQuestions
    }
    
    func switchMode(_ mode: GameMode) {
        historyCurrentMode = mode
        fetchHistoryQuestions()
    }
    
    func fetchHistoryQuestions() {
        guard let userID = KeychainHelper.shared.userId, historyReallyQuestions.isEmpty || newReallyHistory else { return }
        Task {
            let result = await BHController.request(.getFinishedRounds(userID), expected: FinishedFunfactRounds.self)
            switch result {
            case .success(let history):
                for round in history.finishedRounds {
                    self.historyReallyQuestions.append(contentsOf: round.questions)
                }
            case .failure(let error):
                print("Error on fetching histories: \(error)")
            }
        }
    }
    
    // MARK: - Leaderboard
    private var reallyLeaders: [ScoreboardUser] = .init()
    private var thinkSolveLeaders: [ScoreboardUser] = .init()
    
    var reallyLeaderList: [ScoreboardUser] {
        if reallyLeaders.count > 5 {
            return Array(reallyLeaders.prefix(upTo: 5))
        } else {
            return reallyLeaders
        }
    }
    
    var thinkSolveLeaderList: [ScoreboardUser] {
        if thinkSolveLeaders.count > 5 {
            return Array(thinkSolveLeaders.prefix(upTo: reallyLeaders.count + 1))
        } else {
            return thinkSolveLeaders
        }
    }
    
    var userEntryReally: ScoreboardUser {
        let name = KeychainHelper.shared.userName ?? ""
        return reallyLeaders.first { $0.name == name } ?? .init(name: name, score: 0, rank: reallyLeaders.count + 1)
    }
    
    var userEntryThinkSolve: ScoreboardUser {
        let name = KeychainHelper.shared.userName ?? ""
        return thinkSolveLeaders.first { $0.name == name } ?? .init(name: name, score: 0, rank: thinkSolveLeaders.count + 1)
    }
    
    func fetchLeaders() {
        reallyLeaders.removeAll()
        thinkSolveLeaders.removeAll()
        
        Task {
            let result = await BHController.request(.getLeaderboard, expected: Scoreboard.self)
            switch result {
            case .success(let scoreboard):
                reallyLeaders = scoreboard.entries.sorted(by: { $0.rank < $1.rank })
                
            case .failure(let error):
                print("Error fetching Leaderboard: \(error)")
            }
        }
    }
}
