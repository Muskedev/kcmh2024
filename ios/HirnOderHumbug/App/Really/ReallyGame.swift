//
//  XFQuestionView.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct ReallyGame: View {
    
    @Environment(\.appViewModel) private var appViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showScore: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                
                HStack {
                    ForEach(appViewModel.reallyQuestions, id: \.id) { question in
                        if let userAnswer = question.userAnswer {
                            RoundedRectangle(cornerRadius: 3)
                                .fill(question.correctAnswer == userAnswer ? .positive: .negative.opacity(0.5))
                                .frame(maxWidth: .infinity, maxHeight: 5)
                        } else {
                            RoundedRectangle(cornerRadius: 3)
                                .fill(.white.opacity(0.5))
                                .frame(maxWidth: .infinity, maxHeight: 5)
                        }
                    }
                }
                
                BrightonQuestion(mode: .really)
                if !appViewModel.reallyHideButtons {
                    TrueFalseButtons()
                        .animation(.easeInOut, value: appViewModel.reallyHideButtons)
                }
                
                if let question = appViewModel.reallyQuestionExplane {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(appViewModel.reallyCorrect ? "Richtig! Die Aussage stimmt \(question.correctAnswer ? "": "nicht")": "Arggh, da hab ich dich wohl täuschen können.")
                            .font(.answerTrueFalse)
                            .foregroundStyle(appViewModel.reallyCorrect ? .positive: .negative)
                        Text(question.explanation)
                            .font(.answer)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.answerBackground)
                    )
                    
                    if !appViewModel.reallyLastRound {
                        HStack {
                            Text("Nächste Frage")
                            Image(systemName: "chevron.right")
                        }
                        .font(.buttonQuiz)
                        .foregroundStyle(.white)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 20.0)
                                .fill(.white.opacity(0.3))
                        )
                        .button {
                            appViewModel.reallyNextQuestion()
                        }
                    } else {
                        
                        VStack {
                            Text("Dein Punktestand")
                                .font(.pointTitle)
                            Text("\(appViewModel.reallyScore)")
                                .font(.points)
                        }
                        .foregroundStyle(.white)
                        
                        HStack {
                            Text("Neue Runde")
                                .font(.buttonQuiz)
                                .foregroundStyle(.white)
                                .padding(.vertical, 15)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 20.0)
                                        .fill(.white.opacity(0.3))
                                )
                                .button {
                                    appViewModel.endReallyRound(again: true)
                                }
                            
                            Text("Beenden")
                                .font(.buttonQuiz)
                                .foregroundStyle(.negative)
                                .padding(.vertical, 15)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 20.0)
                                        .fill(.white.opacity(0.3))
                                )
                                .button {
                                    appViewModel.endReallyRound(again: false)
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
                    .font(.custom("Mabook", size: 32))
                    .foregroundColor(.white) // Change the title color to blue
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                GameDismissButton()
            }
        }
        .padding()
    }
}
