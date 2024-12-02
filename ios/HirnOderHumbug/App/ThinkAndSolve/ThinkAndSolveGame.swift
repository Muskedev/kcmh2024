//  GenialDanebenView.swift
//  HirnOderHumbug
//
//  Created by Nico on 02.12.24.
//  
//

import SwiftUI

struct ThinkAndSolveGame: View {
    
    @State private var answer: String = ""
    
    var body: some View {
        VStack(spacing: 30) {
            
            BrightonQuestion(clicked: false, question: "Was hat ein Otter immer dabei?")
            
            TextAnswer(text: $answer)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ThinkAndSolveGame()
}