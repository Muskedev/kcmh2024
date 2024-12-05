//  GameDismissButton.swift
//  HirnOderHumbug
//
//  Created by Nico on 03.12.24.
//  
//

import SwiftUI

struct GameDismissButton: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.valueStore) private var valueStore
    
    var body: some View {
        @Bindable var valueStore = valueStore
        
        Image(systemName: "xmark")
            .font(.buttonClose)
            .foregroundStyle(.backgroundTwo.opacity(0.7))
            .padding(8)
            .background(
                .background
                    .shadow(.drop(color: .black.opacity(0.2), radius: 5, x: 5, y: 5))
                    .shadow(.drop(color: .black.opacity(0.12), radius: 5, x: -5, y: -5)),
                in: .capsule
            )
            .button {
                valueStore.showAlert = true
            }
            .alertView(isPresented: $valueStore.showAlert) {
                CustomAlertBoxYesNo("Punktestand im Stich lassen?", message: "Willst du wirklich aufgeben? Dein Punktestand wird nie erfahren, wie großartig es hätte sein können!") { value in
                    if value {
                        dismiss()
                    }
                }
            }
    }
}

#Preview {
    GameDismissButton()
}
