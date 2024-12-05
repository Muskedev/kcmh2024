//
//  FinishedRound.swift
//  HirnOderHumbug
//
//  Created by Mia Koring on 05.12.24.
//

struct FunfactsRound: Codable {
    let score: Int?
    let id: String
    let userId: String
    var questions: [FunfactsQuestion]
}
