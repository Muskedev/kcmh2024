//  CustomAlertBoxYesNo.swift
//  HirnOderHumbug
//
//  Created by Nico on 03.12.24.
//  
//

import SwiftUI

struct CustomAlertBoxYesNo: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.appViewModel) private var appViewModel
    let title: LocalizedStringKey
    let message: LocalizedStringKey
    let action: (Bool) -> ()
    
    init(_ title: LocalizedStringKey = "", message: LocalizedStringKey = "", action: @escaping (Bool) -> Void) {
        self.title = title
        self.message = message
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 40.0) {
            VStack(alignment: .leading, spacing: 10.0) {
                Text(title)
                    .font(.alertTitle)
                
                Text(message)
                    .font(.alertMessage)
            }
            
            HStack {
                Text("Tschüss, Punktestand!")
                    .modifier(AlertButtonStyle(color: .white, backgroundColor: .negative))
                    .button {
                        dismissView(action: true)
                    }
                
                Text("Nein, mein Punktestand braucht mich!")
                    .modifier(AlertButtonStyle(color: .white, backgroundColor: .positive))
                    .button {
                        dismissView(action: false)
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(35)
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(.background)
                .padding(.horizontal)
        }
    }
    
    private func dismissView(action: Bool) {
        appViewModel.showAlert = false
        dismiss()
        self.action(action)
    }
}
