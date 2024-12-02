//
//  BrightonQuestion.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct BrightonQuestion: View {
    
    @Binding var clicked: Bool
    
    var body: some View {
        VStack {
            Text("Ein Otter hat immer einen Lieblingsstein, den er bei sich trägt, um Muscheln zu knacken.")
                .font(.question)
                .padding(.vertical, 40)
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
