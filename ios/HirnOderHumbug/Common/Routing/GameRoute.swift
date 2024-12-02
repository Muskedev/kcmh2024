//
//  GameRoute.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import Routing
import SwiftUI

enum GameRoute: Routable {
    case start(GameMode)
    case end
    
    var body: some View {
        switch self {
        case .start(let mode):
            if mode == .really {
                XFQuestionView()
            } else {
                ThinkAndSolveGame()
            }
        default:
            EmptyView()
        }
    }
}
