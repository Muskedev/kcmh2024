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
                
                VStack {
                    BrightonHeader(head: mode.name, subhead: mode.explanation)
                    
                    Spacer()
                    
                    Text("Drück mich, ich bin der Startknopf!")
                        .modifier(TTButtonStyle(color: Color.backgroundTwo, font: .buttonNormal))
                        .button {
                            router.navigate(to: .start(mode))
                        }
                        .padding(.bottom, 70)
                }
                .padding()
            }
        }
    }
}

#Preview {
    ModeExplanation(mode: .really)
}
