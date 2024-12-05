//
//  Scoreboard.swift
//  HirnOderHumbug
//
//  Created by Mia Koring on 05.12.24.
//

struct Scoreboard: Codable {
    let entries: [ScoreboardUser]
    let gameMode: String
}
