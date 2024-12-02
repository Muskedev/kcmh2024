//
//  GameMode.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

enum GameMode {
    case really
    case thinkSolve
}

extension GameMode {
    var name: String {
        switch self {
        case .really: "Really?"
        case .thinkSolve: "Think & Solve"
        }
    }
    
    var explanation: String {
        switch self {
        case .really: "Standest du auch schonmal vor der Wahl ob etwas richtig oder falsch ist?\n\nZum Beispiel die Aussage \"Goldfische haben ein Gedächtnis, das nur drei Sekunden lang hält.\"\n\n\nHier bekommst du Aussagen, die du als Richtig oder Falsch einstufen kannst. Für jede korrekte Antwort gibt es Punkte."
        case .thinkSolve: "Andere erklärung"
        }
    }
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .really: XFQuestionView()
        case .thinkSolve: ThinkAndSolveGame()
        }
    }
}
