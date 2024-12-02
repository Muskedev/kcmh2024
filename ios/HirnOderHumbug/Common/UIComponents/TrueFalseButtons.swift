//
//  TrueFalseButtons.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI
import SwiftChameleon

struct TrueFalseButtons: View {
    
    @Binding var clicked: Bool
    
    var body: some View {
        HStack(spacing: 20.0) {
            Image(systemName: "checkmark")
                .modifier(TTButtonStyle(color: .mint))
                .button {
                    clicked = true
                }
            
            Image(systemName: "xmark")
                .modifier(TTButtonStyle(color: .pink))
                .button {
                    clicked = false
                }
        }
    }
}

#Preview {
    @Previewable @State var clicked = false
    TrueFalseButtons(clicked: $clicked)
}
