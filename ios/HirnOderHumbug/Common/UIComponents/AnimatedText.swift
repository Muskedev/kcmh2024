//
//  AnimatedText.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 03.12.24.
//

import SwiftUI

struct AnimatedText: View {
    
    // MARK: - Inits
    
    init(_ text: String) {
        self._text = Binding(get: { text }, set: {_ in })
        var attributedText = AttributedString(text)
        attributedText.foregroundColor = .clear
        self._attributedText = State(initialValue: attributedText)
    }
    
    // MARK: - Properties (Private)
    
    @Binding private var text: String?
    @State private var attributedText: AttributedString
    
    // MARK: - Properties (View)
    
    var body: some View {
        Text(attributedText)
            .onAppear { animateText() }
            .onChange(of: text) { animateText() }
    }
    
    // MARK: - Methods (Private)
    
    private func animateText(at position: Int = 0) {
        guard let text else { return }
        if position <= text.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
                let stringStart = String(text.prefix(position))
                let stringEnd = String(text.suffix(text.count - position))
                let attributedTextStart = AttributedString(stringStart)
                var attributedTextEnd = AttributedString(stringEnd)
                attributedTextEnd.foregroundColor = .clear
                attributedText = attributedTextStart + attributedTextEnd
                animateText(at: position + 1)
            }
        } else {
            attributedText = AttributedString(text)
        }
    }
    
}
