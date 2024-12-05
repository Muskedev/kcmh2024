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
            ZStack {
                BHMesh()
                
                VStack(spacing: 30.0) {
                    BrightonHeader(head: mode.name, subhead: mode.explanation)
                    
                    
                    VStack {
                        Text("Labor betreten - Schutzbrille optional")
                            .font(.tabIcon)
                            .foregroundStyle(.white)
                        
                        Image(.startbutton)
                            .resizable()
                            .scaledToFit()
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
                            .shadow(color: Color.white.opacity(0.5), radius: 10, x: -5, y: -5)
                            .frame(maxWidth: .infinity)
                            .button {
                                router.navigate(to: .start(mode))
                            }
                    }
                    .padding(40.0)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}
