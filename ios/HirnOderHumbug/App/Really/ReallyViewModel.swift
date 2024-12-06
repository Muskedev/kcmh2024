//
//  ReallyViewModel.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 05.12.24.
//

import SwiftUI
import SwiftChameleon

@Observable
class ReallyViewModel {
    
    var round: FunfactsRound?
    var currentQuestion: FunfactsQuestion?
    
    var questionHighlights: [FunfactsQuestion] {
        round?.questions ?? []
    }
    
    var maxRounds: Int {
        (round?.questions.count ?? 0) - 1
    }
    
    private var currentRound: Int = 0
    private(set) var answer: Bool = false
    private(set) var score: Int = 0
    private let basepoints: Int = 10
    private var pointMulti = 1
    
    var answerCorrect: Bool {
        currentQuestion?.correctAnswer == currentQuestion?.userAnswer
    }
    
    var isLastRound: Bool {
        currentRound == maxRounds
    }

    func questionHightlight(_ index: Int) -> Bool? {
        return nil
    }
    
    func nextRound() {
        currentRound = 0
        score = 0
        pointMulti = 1
        currentQuestion = nil
        answer = false
        getQuestions()
    }
    
    func nextQuestion() {
        guard let round else { return }
        self.currentRound += 1
        self.currentQuestion = round.questions[self.currentRound]
        self.answer = false
    }
    
    func answer(_ answer: Bool) {
        self.answer = answer
        self.currentQuestion?.userAnswer = answer
        
        if answerCorrect {
            score += basepoints * pointMulti
            pointMulti += 1
        } else {
            pointMulti = 1
        }
        
        guard let currentQuestion, var round else { return }
        round.questions[self.currentRound] = currentQuestion
        self.round = round
    }
    
    func getQuestions() {
        guard let userId = KeychainHelper.shared.userId else { return }
        Task {
            let result = await BHController.request(.createFunfactsRound(userId), expected: FunfactsRound.self)
            switch result {
            case .success(let round):
                self.round = round
                self.currentQuestion = round.questions[self.currentRound]
            case .failure(let error):
                print("Error get funfacts \(error)")
            }
        }
    }
    
    func endRound(more: Bool = false) {
        guard let round, let userId = KeychainHelper.shared.userId else { return }
        var answeredQuestions: [AnsweredQuestion] = []
        
        for question in round.questions {
            if let answer = question.userAnswer {
                answeredQuestions.append(.init(id: question.id, userAnswer: answer))
            }
        }
        
        Task {
            let result = await BHController.request(.finishFunfactsRound(userId, round.id, score, answeredQuestions), expected: FunfactsRound.self)
            
            switch result {
            case .success(let round):
                print(round)
                self.nextRound()
            case .failure(let error):
                print("Error on set score \(error)")
            }
        }
    }
}

