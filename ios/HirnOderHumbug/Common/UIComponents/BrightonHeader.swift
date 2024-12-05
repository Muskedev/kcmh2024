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
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(head)
                    .font(.brightonHead)
                
                Text(subhead.translate)
                    .font(.brightonSubhead)
            }
            .padding(.top, 10)
            .padding(.bottom, 15)
            .padding(.horizontal, 20)
            .background(
                SpeechBubble(direction: .trailing)
                    .fill(.speechBubble)
            )
            
            Image(.brightonTransparent)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
        }
    }
}

#Preview {
    BrightonHeader(head: "Headline", subhead: "Subheadline text erklären etc.")
}
