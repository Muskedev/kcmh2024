//
//  AnsweredQuestion.swift
//  HirnOderHumbug
//
//  Created by Mia Koring on 05.12.24.
//

struct AnsweredQuestion: Codable {
    let id: String
    let userAnswer: Bool
}

struct AnsweredQuestionTS: Codable {
    let explanation: String
    let isUserCorrect: Bool
}
