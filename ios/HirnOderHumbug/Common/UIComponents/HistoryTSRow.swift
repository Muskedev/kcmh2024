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
            VStack(alignment: .leading, spacing: 15.0) {
                
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
                
                Text(
                    """
                    **Erklärung:**
                    Die kleinen Knöpfe sind keine zufälligen Unebenheiten, sondern sogenannte Taktilmarkierungen. Sie helfen sehbehinderten Menschen, den Zebrastreifen zu erkennen. Durch ihren Stock oder mit den Füßen können sie die Erhebung spüren und wissen, wo der Übergang beginnt oder endet.
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
        }
        .padding(.bottom, 10)
    }
}

struct HistoryRRow: View {
    
    var wasCorrect: Bool = true
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading, spacing: 15.0) {
                
                HStack {
                    Text(Date.now, format: .dateTime)
                        .font(.historyDate)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                    Text(wasCorrect ? "wahr": "unwahr")
                        .font(.histryTrueFalse)
                        .foregroundStyle(.white)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(wasCorrect ? .positive: .negative)
                        )
                }
                
                Text("Ein Otter hat immer einen Lieblingsstein, den er bei sich trägt, um Muscheln zu knacken.")
                    .font(.historyTitle)
                    .foregroundStyle(.black)
                
                Text(
                    """
                    **Erklärung:**
                    Seeotter haben tatsächlich einen „Lieblingsstein“, den sie in einer Hautfalte unter ihrem Arm aufbewahren. Sie nutzen diesen Stein, um Muscheln oder andere harte Schalen aufzubrechen, um an das leckere Innere zu gelangen. Manche Otter behalten denselben Stein über Jahre hinweg – wie ein kleines Werkzeug in der Tasche!
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
        }
        .padding(.bottom, 10)
    }
}
