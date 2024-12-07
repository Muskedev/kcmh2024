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
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            
            BrightonQuestion()
            
            TextAnswer(text: $answer)
                .focused($isFocused)
            
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                GameDismissButton()
            }
            
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isFocused = false
                }
            }
        }
    }
}

#Preview {
    ThinkAndSolveGame()
}
