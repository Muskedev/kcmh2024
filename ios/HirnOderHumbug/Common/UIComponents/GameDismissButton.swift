//  GameDismissButton.swift
//  HirnOderHumbug
//
//  Created by Nico on 03.12.24.
//  
//

import SwiftUI

struct GameDismissButton: View {
    
    @State private var showAlertBox: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
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
                showAlertBox = true
            }
            .popView(isPresented: $showAlertBox, onDismiss: {
                
            }) {
                CustomAlertBoxYesNo("Wollen Sie das Spiel wirklich beenden?") { value in
                    showAlertBox = false
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
