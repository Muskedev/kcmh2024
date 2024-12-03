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
                .background
                    .shadow(.drop(color: .black.opacity(0.2), radius: 5, x: 5, y: 5))
                    .shadow(.drop(color: .black.opacity(0.12), radius: 5, x: -5, y: -5)),
                in: .rect(cornerRadius: 15)
            )
    }
}
