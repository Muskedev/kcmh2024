//
//  XFQuestionView.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct ReallyGame: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var clicked: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            
            BrightonQuestion(clicked: clicked, question: .constant("Ein Otter hat immer einen Lieblingsstein, den er bei sich trägt, um Muscheln zu knacken."))
            TrueFalseButtons(clicked: $clicked)
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "xmark")
                    .font(.buttonClose)
                    .foregroundStyle(.pink)
                    .button {
                        dismiss()
                    }
            }
        }
        .padding()
    }
}

#Preview {
    ReallyGame()
}
