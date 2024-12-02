//
//  QuestionMode.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI
import Routing

struct ModeExplanation: View {
    
    // MARK: - Properties
    let mode: GameMode
    @StateObject private var router: Router<GameRoute> = .init()
    
    // MARK: - Body
    var body: some View {
        RoutingView(stack: $router.stack) {
            VStack {
                BrightonHeader(head: mode.name, subhead: mode.explanation)
                
                Spacer()
                
                Text("Start Game")
                    .modifier(TTButtonStyle(color: Color.backgroundOne))
                    .button {
                        router.navigate(to: .start(mode))
                    }
                
                Spacer()
            }
            .padding()
        }
    }
}
