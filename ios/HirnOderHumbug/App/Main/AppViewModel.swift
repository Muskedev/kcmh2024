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
    
    var reallyHideButtons: Bool {
        reallyLastRound && reallyQuestion?.userAnswer != nil
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
            let result = await BHController.request(.createRound(userID, .really), expected: FunfactsRound.self)
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
            let result = await BHController.request(.finishRound(.really, userID, reallyRound.id, reallyScore, answeredQuestions), expected: FunfactsRound.self)
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
    
    // MARK: - Think & Solve
    var thinkSolveRound: ThinkSolveRound?
    var thinkSolveQuestion: ThinkSolveQuestion?
    var thinkSolveCheckedAnswer: AnsweredQuestionTS?
    var thinkSolveUserAnswer: String = ""
    var thinkSolveCurrentRound: Int = 0
    var thinkSolveScore: Int = 0
    var thinkSolveBasePoints: Int = 30
    var thinkSolveMultiplier: Int = 1
    var thinkSolveLoading: Bool = false

    var thinkSolveRounds: Int {
        (thinkSolveRound?.questions.count ?? 1) - 1
    }
    
    var thinkSolveQuestions: [ThinkSolveQuestion] {
        thinkSolveRound?.questions ?? []
    }
    
    var thinkSolveCorrect: Bool {
        thinkSolveQuestion?.correctAnswer ?? false
    }
    
    var thinkSolveLastRound: Bool {
        thinkSolveCurrentRound == thinkSolveRounds
    }
    
    func newThinkSolveRound() {
        thinkSolveReset()
        fetchThinkSolveRound()
    }
    
    func thinkSolveReset() {
        thinkSolveRound = nil
        thinkSolveQuestion = nil
        thinkSolveCheckedAnswer = nil
        thinkSolveUserAnswer = ""
        thinkSolveCurrentRound = 0
        thinkSolveScore = 0
        thinkSolveBasePoints = 30
        thinkSolveMultiplier = 1
        thinkSolveLoading = false
    }
    
    func thinkSolveNextQuestion() {
        guard let thinkSolveRound else { return }
        thinkSolveCurrentRound += 1
        thinkSolveQuestion = thinkSolveRound.questions[thinkSolveCurrentRound]
        thinkSolveUserAnswer = ""
        thinkSolveCheckedAnswer = nil
    }
    
    func fetchThinkSolveRound() {
        guard let userID = KeychainHelper.shared.userId else { return }
        Task {
            let result = await BHController.request(.createRound(userID, .thinkSolve), expected: ThinkSolveRound.self)
            switch result {
            case .success(let round):
                self.thinkSolveRound = round
                self.thinkSolveQuestion = round.questions[self.thinkSolveCurrentRound]
            case .failure(let error):
                print("Error get funfacts \(error)")
            }
        }
    }
    
    func thinkSolveCheckAnswer() {
        thinkSolveLoading = true
        guard let userID = KeychainHelper.shared.userId, let roundID = thinkSolveRound?.id, let questionID = thinkSolveQuestion?.id else { return }
        Task {
            let result = await BHController.request(.answerQuestion(userID, roundID, questionID, thinkSolveUserAnswer), expected: AnsweredQuestionTS.self)
            switch result {
            case .success(let answer):
                self.thinkSolveCheckedAnswer = answer
                self.thinkSolveLoading = false
                
                if answer.isUserCorrect {
                    thinkSolveScore += thinkSolveBasePoints * thinkSolveMultiplier
                    thinkSolveMultiplier += 1
                } else {
                    thinkSolveMultiplier = 1
                }
                
                guard var thinkSolveQuestion, var thinkSolveRound else { return }
                thinkSolveQuestion.userAnswer = thinkSolveUserAnswer
                thinkSolveQuestion.correctAnswer = answer.isUserCorrect
                thinkSolveQuestion.explanation = answer.explanation
                thinkSolveRound.questions[self.thinkSolveCurrentRound] = thinkSolveQuestion
                self.thinkSolveQuestion = thinkSolveQuestion
                self.thinkSolveRound = thinkSolveRound
            case .failure(let error):
                print("Error on check Answer: \(error)")
                self.thinkSolveLoading = false
            }
        }
    }
    
    func endThinkSolveRound(again: Bool) {
        guard let thinkSolveRound, let userID = KeychainHelper.shared.userId else { return }
        
        Task {
            let result = await BHController.request(.finishRound(.thinkSolve, userID, thinkSolveRound.id, thinkSolveScore, []), expected: ThinkSolveRound.self)
            switch result {
            case .success:
                self.newThinkSolveHistory = true
                if again {
                    self.newThinkSolveRound()
                } else {
                    self.thinkSolveReset()
                }
            case .failure(let error):
                print("Error on set score \(error)")
            }
        }
    }
    
    //MARK: - History
    var historyReallyQuestions: [FunfactsQuestion] = .init()
    var historyThinkSolveQuestions: [ThinkSolveQuestion] = .init()
    var historyCurrentMode: TTSegment = .reallyHistory {
        didSet {
            switchMode(historyCurrentMode.gameMode)
        }
    }
    var historyLoading: Bool = false
    
    var reallyHistoryStreak: Int {
        var maxStreak: Int = 0
        var currentStreak: Int = 0
        
        for question in historyReallyQuestions {
            if question.correctAnswer == question.userAnswer {
                currentStreak += 1
                maxStreak = max(maxStreak, currentStreak)
            } else {
                currentStreak = 0
            }
        }
        
        return maxStreak
    }
    
    var thinkSolveHistoryStreak: Int {
        var maxStreak: Int = 0
        var currentStreak: Int = 0
        
        for question in historyThinkSolveQuestions {
            if question.correctAnswer ?? false {
                currentStreak += 1
                maxStreak = max(maxStreak, currentStreak)
            } else {
                currentStreak = 0
            }
        }
        
        return maxStreak
    }
    
    var reallyHistoryCorrect: Double {
        guard !historyReallyQuestions.isEmpty else { return 0 }
        let correct = Double(historyReallyQuestions.filter({ $0.correctAnswer == $0.userAnswer }).count.double)
        let all = Double(historyReallyQuestions.count)
        return (correct / all) * 100
    }
    
    var thinkSolveHistoryCorrect: Double {
        guard !historyThinkSolveQuestions.isEmpty else { return 0 }
        let correct = Double(historyThinkSolveQuestions.filter({ $0.correctAnswer ?? false }).count.double)
        let all = Double(historyThinkSolveQuestions.count)
        return (correct / all) * 100
    }
    
    func switchMode(_ mode: GameMode) {
        historyLoading = true
        Task {
            await fetchFunfactHistory()
            await fetchThinkSolveHistory()
        }
    }
    
    func fetchFunfactHistory() async {
        guard let userID = KeychainHelper.shared.userId else {
            self.historyLoading = false
            return
        }
        let result = await BHController.request(.getFinishedRounds(userID, .really), expected: FinishedFunfactRounds.self)
        switch result {
        case .success(let history):
            self.historyReallyQuestions.removeAll()
            for round in history.finishedRounds {
                self.historyReallyQuestions.append(contentsOf: round.questions)
            }
            self.historyLoading = false
        case .failure(let error):
            print("Error on fetching histories: \(error)")
            self.historyLoading = false
        }
    }
    
    func fetchThinkSolveHistory() async {
        guard let userID = KeychainHelper.shared.userId else {
            self.historyLoading = false
            return
        }
        
        let result = await BHController.request(.getFinishedRounds(userID, .thinkSolve), expected: FinishedThinkSolveRound.self)
        switch result {
        case .success(let history):
            self.historyThinkSolveQuestions.removeAll()
            for round in history.finishedRounds {
                self.historyThinkSolveQuestions.append(contentsOf: round.questions)
            }
            self.historyLoading = false
        case .failure(let error):
            print("Error on fetching histories: \(error)")
            self.historyLoading = false
        }
    }
    
    // MARK: - Leaderboard
    private var reallyLeaders: [ScoreboardUser] = .init()
    private var thinkSolveLeaders: [ScoreboardUser] = .init()
    var leaderMode: TTSegment = .allLeader
    var leaderLoad: Bool = false
    
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
    
    var bothLeaderList: [ScoreboardUser] {
        let check = reallyLeaders + thinkSolveLeaders
        
        var scoreDict: [String: Int] = [:]
        var new: [ScoreboardUser] = []
        
        for item in check {
            scoreDict[item.name, default: 0] += item.score
        }
        
        for dict in scoreDict {
            new.append(.init(name: dict.key, score: dict.value, rank: 0))
        }
        
        var sorted = new.sorted { $0.score > $1.score }
        new = []
        for (index, item) in sorted.enumerated() {
            new.append(.init(name: item.name, score: item.score, rank: index + 1))
        }
        
        return new
    }
    
    var leaderboardItems: [ScoreboardUser] {
        switch leaderMode {
        case .reallyLeader: reallyLeaderList
        case .thinkSolveLeader: thinkSolveLeaderList
        default: bothLeaderList
        }
    }
    
    var userLeaderEntry: ScoreboardUser? {
        let name = KeychainHelper.shared.userName ?? ""
        switch leaderMode {
        case .reallyLeader: return reallyLeaders.first { $0.name == name }
        case .thinkSolveLeader: return thinkSolveLeaders.first { $0.name == name }
        default: return bothLeaderList.first { $0.name == name }
        }
    }
    
    var userEntryThinkSolve: ScoreboardUser {
        let name = KeychainHelper.shared.userName ?? ""
        return thinkSolveLeaders.first { $0.name == name } ?? .init(name: name, score: 0, rank: thinkSolveLeaders.count + 1)
    }
    
    func fetchLeaders() {
        reallyLeaders.removeAll()
        thinkSolveLeaders.removeAll()
        leaderLoad = true
        Task {
            if leaderMode != .allLeader {
                await fetchLeader(leaderMode.gameMode)
            } else {
                await fetchLeader(.really)
                await fetchLeader(.thinkSolve)
            }
        }
    }
    
    func fetchLeader(_ mode: GameMode) async {
        Task {
            let resultReally = await BHController.request(.getLeaderboard(mode), expected: Scoreboard.self)
            switch resultReally {
            case .success(let scoreboard):
                if mode == .really {
                    print("ReallyBoard: \(scoreboard)")
                    reallyLeaders = scoreboard.entries.sorted(by: { $0.rank < $1.rank })
                    if leaderMode != .allLeader {
                        self.leaderLoad = false
                    }
                } else {
                    print("ThinkSolve: \(scoreboard)")
                    thinkSolveLeaders = scoreboard.entries.sorted(by: { $0.rank < $1.rank })
                    self.leaderLoad = false
                }
                
            case .failure(let error):
                print("Error fetching Leaderboard: \(error)")
                self.leaderLoad = false
            }
        }
    }
}
