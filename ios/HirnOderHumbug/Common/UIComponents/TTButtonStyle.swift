//
//  TTButtonStyle.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct TTButtonStyle: ViewModifier {
    
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
