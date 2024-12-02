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
                .modifier(ButtonStyle(color: .mint))
                .button {
                    clicked = true
                }
            
            Image(systemName: "xmark")
                .modifier(ButtonStyle(color: .pink))
                .button {
                    clicked = false
                }
        }
    }
}

private struct ButtonStyle: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.buttonBool)
            .foregroundStyle(color)
            .frame(maxWidth: .infinity, maxHeight: 60.0)
            .background(.white)
            .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    @Previewable @State var clicked = false
    TrueFalseButtons(clicked: $clicked)
}
