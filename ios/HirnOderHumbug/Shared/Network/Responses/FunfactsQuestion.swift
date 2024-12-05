//
//  FinishedQuestion.swift
//  HirnOderHumbug
//
//  Created by Mia Koring on 05.12.24.
//

struct FunfactsQuestion: Codable {
    let id: String
    let question: String
    let explanation: String
    let userAnswer: Bool?
    let correctAnswer: Bool
}
