//
//  TTButtonStyle.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct TTButtonStyle: ViewModifier {
    
    let color: Color
    let font: Font
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundStyle(color)
            .frame(maxWidth: .infinity, minHeight: 60.0, maxHeight: 60.0)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.actionButton)
            )
    }
}
