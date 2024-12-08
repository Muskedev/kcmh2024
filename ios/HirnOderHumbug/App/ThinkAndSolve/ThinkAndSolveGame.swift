//  GenialDanebenView.swift
//  HirnOderHumbug
//
//  Created by Nico on 02.12.24.
//  
//

import SwiftUI

struct ThinkAndSolveGame: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.appViewModel) private var appViewModel
    @State private var answer: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        @Bindable var appViewModel = appViewModel
        
        ScrollView {
            VStack(spacing: 30) {
                
                BrightonQuestion()
                
                TextField("Antwort", text: $appViewModel.thinkSolveUserAnswer)
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 150, maxHeight: 150)
                    .background(.speechBubble)
                    .clipShape(.rect(cornerRadius: 20))
                    .focused($isFocused)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Button("Antwort prüfen") {
                                isFocused = false
                                appViewModel.thinkSolveCheckAnswer()
                            }
                        }
                    }
                
                Spacer()
            }
        }
        .scrollIndicators(.hidden)
        .padding()
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                GameDismissButton()
            }
        }
    }
}

#Preview {
    ThinkAndSolveGame()
}
