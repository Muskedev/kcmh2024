//
//  TrueFalseButtons.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI
import SwiftChameleon

struct TrueFalseButtons: View {
    
    @Environment(\.appViewModel) private var appViewModel
    
    var body: some View {
        HStack(spacing: 20.0) {
            HStack {
                Image(systemName: "checkmark")
                    .font(.buttonBool)
                Text("Wahr")
            }
            .modifier(TTButtonStyle(color: .positive, font: .historyTrueFalse))
            .button {
                withAnimation(.smooth(duration: 1)) {
                    appViewModel.reallyAnswer(true)
                }
            }
            .disabled(isButtonDisabled())
            .opacity(isButtonDisabled() ? 0.75 : 1)
            
            HStack {
                Image(systemName: "xmark")
                    .font(.buttonBool)
                Text("Falsch")
            }
            .modifier(TTButtonStyle(color: .negative, font: .historyTrueFalse))
            .button {
                withAnimation(.smooth(duration: 1)) {
                    appViewModel.reallyAnswer(false)
                }
            }
            .disabled(isButtonDisabled())
            .opacity(isButtonDisabled() ? 0.75 : 1)
        }
    }
    
    func isButtonDisabled() -> Bool {
        appViewModel.reallyQuestion.isNil || appViewModel.reallyQuestion?.userAnswer != nil
    }
}
