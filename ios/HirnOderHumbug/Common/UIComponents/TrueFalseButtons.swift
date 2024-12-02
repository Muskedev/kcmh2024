//
//  TrueFalseButtons.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct TrueFalseButtons: View {
    
    @Binding var clicked: Bool
    
    var body: some View {
        HStack(spacing: 20.0) {
            Button {
                clicked = true
            } label: {
                Image(systemName: "checkmark")
                    .font(.buttonBool)
                    .foregroundStyle(.mint)
                    .frame(maxWidth: .infinity, maxHeight: 60.0)
            }
            .background(.white)
            .clipShape(.rect(cornerRadius: 20))
            
            Button {
                clicked = false
            } label: {
                Image(systemName: "xmark")
                    .font(.buttonBool)
                    .foregroundStyle(.pink)
                    .frame(maxWidth: .infinity, maxHeight: 60.0)
            }
            .background(.white)
            .clipShape(.rect(cornerRadius: 20))
        }
    }
}
