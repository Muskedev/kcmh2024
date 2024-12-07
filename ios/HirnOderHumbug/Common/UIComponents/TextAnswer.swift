//
//  TextAnswer.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct TextAnswer: View {
    
    @Binding var text: String
    
    var body: some View {
        TextView(text: $text)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 200)
            .background(.speechBubble)
            .clipShape(.rect(cornerRadius: 20))
            .foregroundStyle(.textField)
    }
}
