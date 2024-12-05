//
//  BrightonQuestion.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct BrightonQuestion: View {
    
    var clicked: Bool = false
    @Binding var question: String
    @State var isLoading: Bool = true
    
    var body: some View {
        VStack {
            ZStack {
                if isLoading {
                    Image(systemName: "ellipsis")
                        .font(.largeTitle)
                        .foregroundStyle(.gray)
                        .symbolEffect(.wiggle.up.byLayer, options: .repeat(.continuous))
                } else {
                    AnimatedText($question)
                        .font(.question)
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
                    view.rotation3DEffect(.init(degrees: clicked ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isLoading.toggle()
                    self.question = self.question
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var clicked = false
    @Previewable @State var question: String = "Hallo Welt?"
    VStack {
        Button("Test") {
            clicked.toggle()
        }
        BrightonQuestion(clicked: clicked, question: $question)
    }
}
