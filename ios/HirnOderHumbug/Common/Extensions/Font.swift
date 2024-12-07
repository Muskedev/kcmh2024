//
//  Font.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

extension SwiftUI.Font {
    static let tabIcon: Font = .system(size: 18.0, weight: .semibold)
    static let tabText: Font = custom("Mabook", size: 14)
    static let question: Font = .system(size: 16, weight: .bold)
    static let answerTrueFalse: Font = .system(size: 14.0, weight: .black)
    static let answer: Font = .system(size: 12.0, weight: .regular)
    static let buttonBool: Font = .system(size: 26, weight: .bold)
    static let buttonClose: Font = .system(size: 16, weight: .semibold)
    static let buttonNormal: Font = .system(size: 16, weight: .semibold)
    static let brightonHead: Font = .custom("Mabook", size: 18)
    static let brightonSubhead: Font = .system(size: 12.0)
    
    static let pointTitle: Font = .custom("Mabook", size: 26)
    static let buttonQuiz: Font = .custom("Mabook", size: 28)
    static let points: Font = .custom("Mabook", size: 52)
    
    static let alertTitle: Font = .system(size: 18.0, weight: .semibold)
    static let alertMessage: Font = .system(size: 14.0, weight: .regular)
    static let alertButton: Font = .system(size: 12, weight: .bold)
    
    static let historyDate: Font = .system(size: 10.0)
    static let historyTitle: Font = .system(size: 14.0, weight: .bold)
    static let historyAnswer: Font = .system(size: 12.0)
    static let historyAnswerTrueFalse: Font = .system(size: 12.0, weight: .semibold)
    static let historyButtonIcon: Font = .system(size: 22.0)
    static let historyButtonText: Font = .custom("Mabook", size: 16)
    static let historyTrueFalse: Font = .custom("Mabook", size: 20)
    
    static let aboutUsName: Font = .custom("Mabook", size: 18)
    static let aboutUsRole: Font = .system(size: 14, weight: .light)
    
    static let leaderboardHead: Font = .custom("Mabook", size: 26)
    
    static let statHeader: Font = .custom("Mabook", size: 20)
    static let statValue: Font = .custom("Mabook", size: 26)
    
    static let segmentFont: Font = .custom("Mabook", size: 16)
    static let segmentHistory: Font = .custom("Mabook", size: 20)
}
 
