//
//  XFQuestionView.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct XFQuestionView: View {
    
    @State private var clicked: Bool = false
    @State private var answer: String = ""
    
    var body: some View {
        VStack(spacing: 30) {
            
            BrightonQuestion(clicked: $clicked, question: "Ein Otter hat immer einen Lieblingsstein, de er bei sich trägt, um Muscheln zu knacken.")
            TrueFalseButtons(clicked: $clicked)
            
            TextAnswer(text: $answer)
            
            Spacer()
        }
        .padding()
    }
}
