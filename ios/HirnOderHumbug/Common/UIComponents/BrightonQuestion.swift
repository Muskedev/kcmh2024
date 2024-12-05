//
//  BrightonQuestion.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct BrightonQuestion: View {
    
    @Environment(\.reallyViewModel) private var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        VStack {
            ZStack {
                if let question = viewModel.currentQuestion {
                    AnimatedText(question.question)
                        .font(.question)
                } else {
                    VStack(spacing: 10.0) {
                        Image(systemName: "ellipsis")
                            .font(.largeTitle)
                            .foregroundStyle(.gray)
                            .symbolEffect(.wiggle.up.byLayer, options: .repeat(.continuous))
                        
                        Text("Kurzen moment, ich überleg mir was neues...")
                            .font(.answer)
                    }
                }
            }
            .padding(.top, 15)
            .padding(.bottom, 25)
            .padding(.horizontal, 30)
            .background(
                SpeechBubble()
                    .fill(.speechBubble)
            )
            
            Image(.brightonTransparent)
                .resizable()
                .scaledToFit()
                .frame(width: 130)
                .animation(.spring) { view in
                    view.rotation3DEffect(.init(degrees: viewModel.answer ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                }
        }
        .onAppear {
            viewModel.nextRound()
        }
    }
}
