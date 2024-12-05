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
    
    private struct ReallyAnswer {
        let question: ReallyFallback
        let answerCorrect: Bool
    }
    
    private var fallback: [ReallyFallback]
    private var done: [ReallyAnswer] = []
    private var currentRound: Int = 0
    let maxRounds: Int = 5
    private(set) var currentQuestion: ReallyFallback?
    private(set) var answer: Bool = false
    private(set) var currentAnswer: Bool?
    private(set) var score: Int = 0
    private let basepoints: Int = 10
    private var pointMulti = 1
    
    var answerCorrect: Bool {
        currentQuestion?.answer == currentAnswer
    }
    var isLastRound: Bool {
        currentRound == maxRounds
    }

    func questionHightlight(_ index: Int) -> Bool? {
        return done.indices.contains(index) ? done[index].answerCorrect : nil
    }
    
    init() {
        self.fallback = ReallyViewModel.getFallbackData()
    }
    
    func nextRound() {
        currentRound = 0
        score = 0
        pointMulti = 1
        currentQuestion = nil
        answer = false
        currentAnswer = nil
        done = []
        nextQuestion()
    }
    
    func nextQuestion() {
        guard currentRound < maxRounds else { return }
        currentQuestion = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.chooseQuestion()
            self.currentRound += 1
            self.answer = false
            self.currentAnswer = nil
        }
    }
    
    func answer(_ answer: Bool) {
        guard let currentQuestion else { return }
        self.answer = answer
        self.currentAnswer = answer
        done.append(.init(question: currentQuestion, answerCorrect: answerCorrect))
        
        if answerCorrect {
            score += basepoints * pointMulti
            pointMulti += 1
        } else {
            pointMulti = 1
        }
    }
    
    func chooseQuestion() {
        let available = fallback.filter({ question in
            return !done.contains(where: { $0.question == question })
        })
        self.currentQuestion = available.randomElement()
    }
    
    static func getFallbackData() -> [ReallyFallback] {
        
        var fallbackData: [ReallyFallback] = []
        
        if let data = JSONHandler.load("really") {
            do {
                let decoded = try data.decoded(Questions<ReallyFallback>.self)
                fallbackData = decoded.questions
            } catch {
                print("Error on loading JSON Fallback: \(error)")
            }
        }
        
        return fallbackData
    }
}

struct Questions<T: Codable>: Codable {
    let questions: [T]
}

struct ReallyFallback: Codable, Hashable {
    let id: Int
    let question: String
    let answer: Bool
    let explanation: String
}

