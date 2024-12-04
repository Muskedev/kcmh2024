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
            .padding(.vertical, 15.0)
            .foregroundStyle(color)
            .frame(maxWidth: .infinity, maxHeight: 60)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(backgroundColor)
            }
    }
}

#Preview {
    Button("TestButton") {
    
    }
    .modifier(AlertButtonStyle(color: .black, backgroundColor: .red))
}
