//
//  TrueFalseButtons.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI
import SwiftChameleon

struct TrueFalseButtons: View {
    
    @Environment(\.reallyViewModel) private var viewModel
    
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
                    viewModel.answer(true)
                }
            }
            .disabled(viewModel.currentQuestion.isNil)
            
            HStack {
                Image(systemName: "xmark")
                    .font(.buttonBool)
                Text("Falsch")
            }
            .modifier(TTButtonStyle(color: .negative, font: .historyTrueFalse))
            .button {
                withAnimation(.smooth(duration: 1)) {
                    viewModel.answer(false)
                }
            }
            .disabled(viewModel.currentQuestion.isNil)
        }
    }
}
