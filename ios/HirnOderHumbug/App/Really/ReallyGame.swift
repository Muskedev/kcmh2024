//
//  XFQuestionView.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct ReallyGame: View {
    
    @State private var clicked: Bool = false
    @State private var question: String = "Ein Otter hat immer einen Lieblingsstein, den er bei sich trägt, um Muscheln zu knacken."
    var answer: String = """
    Seeotter haben tatsächlich einen „Lieblingsstein“, den sie in einer Hautfalte unter ihrem Arm aufbewahren. Sie nutzen diesen Stein, um Muscheln oder andere harte Schalen aufzubrechen, um an das leckere Innere zu gelangen. Manche Otter behalten denselben Stein über Jahre hinweg – wie ein kleines Werkzeug in der Tasche! 😊
    """
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                
                BrightonQuestion(clicked: clicked, question: $question)
                TrueFalseButtons(clicked: $clicked)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(clicked ? "Richtig! Die Aussage stimmt": "Arggh, da hab ich dich wohl täuschen können.")
                        .font(.answerTrueFalse)
                        .foregroundStyle(clicked ? .positive: .negative)
                    Text(answer)
                        .font(.answer)
                }
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.backgroundTwo.opacity(0.5))
                )
                
                HStack {
                    Text(clicked ? "Nächste Frage": "Runde beenden")
                    if clicked {
                        Image(systemName: "chevron.right")
                    }
                }
                .font(.buttonNormal)
                .foregroundStyle(.white)
                .button {
                    // next
                }
                
                Spacer()
                
            }
        }
        .safeAreaInset(edge: .bottom, content: {
            Color.clear.frame(height: 50) // Adds a safe area inset of 50 points at the bottom
        })
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(GameMode.really.name)
                    .font(.buttonBool)
                    .foregroundColor(.white) // Change the title color to blue
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                GameDismissButton()
            }
        }
        .padding()
    }
}

#Preview {
    ReallyGame()
}
