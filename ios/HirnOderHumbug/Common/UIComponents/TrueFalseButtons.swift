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
            Image(systemName: "checkmark")
                .modifier(TTButtonStyle(color: .positive, font: .buttonBool))
                .button {
                    withAnimation(.smooth(duration: 1)) {
                        viewModel.answer(true)
                    }
                }
                .disabled(viewModel.currentQuestion.isNil)
            
            Image(systemName: "xmark")
                .modifier(TTButtonStyle(color: .negative, font: .buttonBool))
                .button {
                    withAnimation(.smooth(duration: 1)) {
                        viewModel.answer(false)
                    }
                }
                .disabled(viewModel.currentQuestion.isNil)
        }
    }
}
