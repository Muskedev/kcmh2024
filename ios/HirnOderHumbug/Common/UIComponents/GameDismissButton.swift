//  GameDismissButton.swift
//  HirnOderHumbug
//
//  Created by Nico on 03.12.24.
//  
//

import SwiftUI

struct GameDismissButton: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.appViewModel) private var appViewModel
    
    var body: some View {
        @Bindable var appViewModel = appViewModel
        
        Text("X")
            .font(.buttonQuiz)
            .foregroundStyle(.backgroundTwo)
            .padding(12)
            .background(
                .background
                    .shadow(.drop(color: .black.opacity(0.2), radius: 5, x: 5, y: 5))
                    .shadow(.drop(color: .black.opacity(0.12), radius: 5, x: -5, y: -5)),
                in: .circle
            )
            .button {
                appViewModel.showAlert = true
            }
            .alertView(isPresented: $appViewModel.showAlert) {
                CustomAlertBoxYesNo("Punktestand im Stich lassen?", message: "Willst du wirklich aufgeben? Dein Punktestand wird nie erfahren, wie großartig es hätte sein können!") { value in
                    if value {
                        dismiss()
                    }
                }
            }
    }
}
