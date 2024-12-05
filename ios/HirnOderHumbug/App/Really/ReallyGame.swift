//
//  XFQuestionView.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct ReallyGame: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.reallyViewModel) private var viewModel
    @State private var showScore: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                
                HStack {
                    ForEach(0..<viewModel.maxRounds, id: \.self) { index in
                        if let highlight = viewModel.questionHightlight(index) {
                            RoundedRectangle(cornerRadius: 3)
                                .fill(highlight ? .positive: .negative.opacity(0.5))
                                .frame(maxWidth: .infinity, maxHeight: 5)
                        } else {
                            RoundedRectangle(cornerRadius: 3)
                                .fill(.white.opacity(0.5))
                                .frame(maxWidth: .infinity, maxHeight: 5)
                        }
                    }
                }
                BrightonQuestion()
                TrueFalseButtons()
                
                if viewModel.currentAnswer.isNotNil, let question = viewModel.currentQuestion {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(viewModel.answerCorrect ? "Richtig! Die Aussage stimmt \(question.answer ? "": "nicht")": "Arggh, da hab ich dich wohl täuschen können.")
                            .font(.answerTrueFalse)
                            .foregroundStyle(viewModel.answerCorrect ? .positive: .negative)
                        AnimatedText(question.explanation)
                            .font(.answer)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.answerBackground)
                    )
                    
                    if !viewModel.isLastRound {
                        HStack {
                            Text("Nächste Frage")
                            Image(systemName: "chevron.right")
                        }
                        .font(.buttonNormal)
                        .foregroundStyle(.white)
                        .button {
                            viewModel.nextQuestion()
                        }
                    }
                    
                    if viewModel.isLastRound {
                        
                        VStack {
                            Text("Dein Punktestand")
                                .font(.question)
                            Text(viewModel.score.description)
                                .font(.buttonBool)
                        }
                        .foregroundStyle(.white)
                        
                        HStack {
                            Text("Neue Runde")
                                .frame(maxWidth: .infinity)
                                .font(.buttonNormal)
                                .foregroundStyle(.white)
                                .button {
                                    viewModel.nextRound()
                                }
                            
                            Text("Beenden")
                                .frame(maxWidth: .infinity)
                                .font(.buttonNormal)
                                .foregroundStyle(.white)
                                .button {
                                    dismiss()
                                }
                        }
                    }
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
