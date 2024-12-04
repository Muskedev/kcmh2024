//
//  HistoryTSRow.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 04.12.24.
//

import SwiftUI

struct HistoryTSRow: View {
    
    var wasCorrect: Bool = true
    @Environment(\.valueStore) private var valueStore
    
    var body: some View {
        @Bindable var valueStore = valueStore
        
        ZStack {
            VStack(alignment: .leading, spacing: 10.0) {
                
                Text(Date.now, format: .dateTime)
                    .font(.historyDate)
                    .foregroundStyle(.gray)
                
                Text("Warum haben manche Zebrastreifen auf der Straße kleine Knöpfe an ihren Streifen?")
                    .font(.historyTitle)
                    .foregroundStyle(.black)
                
                Text(
                    """
                    **Deine Antwort:**
                    Die sind für Menschen die eine eingeschränkte fähigkeit des Sehens haben und mit dem Stock dort entlangfahren.
                    """
                )
                .font(.historyAnswer)
                .foregroundStyle(.black)
                
                Text("Du hast \(wasCorrect ? "korrekt": "leider falsch") geantwortet")
                    .font(.historyAnswerTrueFalse)
                    .foregroundStyle(wasCorrect ? .positive: .negative)
                    
            }
            .multilineTextAlignment(.leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20.0)
                    .fill(.white)
            )
            
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "info.bubble.fill")
                        .font(.historyInfo)
                        .foregroundStyle(.backgroundThree.opacity(0.7))
                        .padding(10.0)
                        .button {
                            
                        }
                }
                Spacer()
            }
        }
        .padding(.bottom, 10)
    }
}

struct HistoryRRow: View {
    var body: some View {
        Text("HistoryTSRow")
    }
}
