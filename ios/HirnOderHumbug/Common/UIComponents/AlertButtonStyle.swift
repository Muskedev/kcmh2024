//  AlertButtonStyle.swift
//  HirnOderHumbug
//
//  Created by Nico on 03.12.24.
//  
//

import SwiftUI

struct AlertButtonStyle: ViewModifier {
    
    let color: Color
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.alertButton)
            .foregroundStyle(color)
            .frame(maxWidth: .infinity, minHeight: 60.0, maxHeight: 60.0)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(backgroundColor.gradient)
            }
    }
}

#Preview {
    Button("TestButton") {
    
    }
    .modifier(AlertButtonStyle(color: .black, backgroundColor: .red))
}
