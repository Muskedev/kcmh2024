//
//  BrightonHeader.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct BrightonHeader: View {
    
    let head: String
    let subhead: String

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 15) {
                Text(head)
                    .font(.brightonHead)
                
                Text(subhead)
                    .font(.brightonSubhead)
            }
            .padding(.top, 35)
            .padding(.bottom, 45)
            .padding(.horizontal, 30)
            .background(
                SpeechBubble()
                    .fill(.white)
            )
            
            Image(.brightonTransparent)
                .resizable()
                .scaledToFit()
                .frame(width: 150)
        }
    }
}

#Preview {
    BrightonHeader(head: "Headline", subhead: "Subheadline text erklären etc.")
}
