//
//  FinishedQuestion.swift
//  HirnOderHumbug
//
//  Created by Mia Koring on 05.12.24.
//

struct FunfactsQuestion: Codable, Equatable {
    let id: String
    let question: String
    let explanation: String
    var userAnswer: Bool?
    let correctAnswer: Bool
}

struct ThinkSolveQuestion: Codable, Equatable {
    let id: String
    let question: String
    var explanation: String?
    var userAnswer: String?
    var correctAnswer: Bool?
}

