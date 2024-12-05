//
//  FinishedRound.swift
//  HirnOderHumbug
//
//  Created by Mia Koring on 05.12.24.
//

struct FinishedFunfactsRound: Codable {
    let score: Int?
    let id: String
    let userId: String
    let questions: [FunfactsQuestion]
}
