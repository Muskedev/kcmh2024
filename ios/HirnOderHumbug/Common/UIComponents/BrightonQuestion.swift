//
//  BrightonQuestion.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct BrightonQuestion: View {
    
    var clicked: Bool = false
    let question: String
    
    var body: some View {
        VStack {
            Text(question)
                .font(.question)
                .padding(.top, 35)
                .padding(.bottom, 45)
                .padding(.horizontal, 30)
                .background(
                    SpeechBubble()
                        .fill(.white)
                )
            
            Image(.brightonTransparent)
                .resizable()
                .scaledToFit()
                .frame(width: 150)
                .animation(.spring) { view in
                    view.rotation3DEffect(.init(degrees: clicked ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                }
        }
    }
}

#Preview {
    @Previewable @State var clicked = false
    VStack {
        Button("Test") {
            clicked.toggle()
        }
        BrightonQuestion(clicked: clicked, question: "Hallo Welt?")
    }
}
