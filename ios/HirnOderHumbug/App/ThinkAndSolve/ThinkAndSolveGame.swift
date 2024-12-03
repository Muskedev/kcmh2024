//  GenialDanebenView.swift
//  HirnOderHumbug
//
//  Created by Nico on 02.12.24.
//  
//

import SwiftUI

struct ThinkAndSolveGame: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var answer: String = ""
    
    var body: some View {
        VStack(spacing: 30) {
            
            BrightonQuestion(clicked: false, question: .constant("Was hat ein Otter immer dabei?"))
            
            TextAnswer(text: $answer)
            
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "xmark")
                    .font(.buttonClose)
                    .foregroundStyle(.pink)
                    .padding(8)
                    .background(
                        .background
                            .shadow(.drop(color: .black.opacity(0.2), radius: 5, x: 5, y: 5))
                            .shadow(.drop(color: .black.opacity(0.12), radius: 5, x: -5, y: -5)),
                        in: .capsule
                    )
                    .button {
                        dismiss()
                    }
            }
        }
    }
}

#Preview {
    ThinkAndSolveGame()
}
