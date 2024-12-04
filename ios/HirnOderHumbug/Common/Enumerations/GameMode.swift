//
//  GameMode.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

enum GameMode: Int, CaseIterable {
    case really = 0
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
        case .really: 
            return """
            Hier kommt deine Chance, der König oder die Königin des unnützen Wissens zu werden! Du bekommst schräge FunFacts serviert, und du musst herausfinden: Sind sie echt oder kompletter Quatsch? Richtig geraten? Punkte für dich! Falsch geraten? Naja, wenigstens hast du was gelernt (vielleicht).
            
            Mach dich bereit, dein Gehirn zu kitzeln und deine Freunde mit absurden Fakten zu beeindrucken!
            """
        case .thinkSolve:
            return """
            Hirnschmalz an und los geht’s! Hier bekommst du knifflige Fragen gestellt, und du musst die richtige Antwort selbst eintippen. Keine Multiple-Choice-Bequemlichkeit – jetzt wird’s ernst! Aber keine Sorge, schlaue Köpfe wie du rocken das sicher.
            
            Kämpfe um Punkte, lerne was Neues und bring dein Wissen auf den nächsten Level. Let’s get quizzical!
            """
        }
    }
    
    var icon: String {
        switch self {
        case .really: "checkmark.circle.badge.xmark"
        case .thinkSolve: "questionmark.bubble"
        }
    }
}
