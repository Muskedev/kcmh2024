//
//  TextView.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> some UIView {
        let textView = UITextView()
        
        textView.font = .systemFont(ofSize: 18, weight: .bold)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true

        return textView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let uiView = uiView as? UITextView else { return }
        uiView.text = text
    }
}
