//  GenialDanebenView.swift
//  HirnOderHumbug
//
//  Created by Nico on 02.12.24.
//  
//

import SwiftUI

struct ThinkAndSolveGame: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.appViewModel) private var appViewModel
    @State private var answer: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        @Bindable var appViewModel = appViewModel
        
        ScrollView {
            VStack(spacing: 20) {
                
                HStack {
                    ForEach(appViewModel.thinkSolveQuestions, id: \.id) { question in
                        if question.userAnswer != nil {
                            RoundedRectangle(cornerRadius: 3)
                                .fill(question.correctAnswer ?? false ? .positive: .negative.opacity(0.5))
                                .frame(maxWidth: .infinity, maxHeight: 5)
                        } else {
                            RoundedRectangle(cornerRadius: 3)
                                .fill(.white.opacity(0.5))
                                .frame(maxWidth: .infinity, maxHeight: 5)
                        }
                    }
                }
                
                BrightonQuestion(mode: .thinkSolve)
                
                if appViewModel.thinkSolveQuestion != nil {
                    ZStack {
                        
                        if appViewModel.thinkSolveLoading {
                            Image(systemName: "ellipsis")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                                .symbolEffect(.wiggle.up.byLayer, options: .repeat(.continuous))
                                .padding(.top, 80)
                        } else if appViewModel.thinkSolveCheckedAnswer != nil {
                            Text(appViewModel.thinkSolveUserAnswer)
                                .font(.question)
                                .frame(maxWidth: .infinity)
                                .padding(15)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.answerBackground)
                                )
                        } else {
                            TextField("Antwort", text: $appViewModel.thinkSolveUserAnswer, axis: .vertical)
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 150, maxHeight: 150)
                                .background(.speechBubble)
                                .clipShape(.rect(cornerRadius: 20))
                                .focused($isFocused)
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Button("Antwort prüfen") {
                                            isFocused = false
                                            appViewModel.thinkSolveCheckAnswer()
                                        }
                                        .disabled(appViewModel.thinkSolveUserAnswer.isEmpty)
                                    }
                                }
                        }
                    }
                }
                
                if let answered = appViewModel.thinkSolveCheckedAnswer {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(answered.isUserCorrect ? "Richtig!": "Das ist leider Falsch.")
                            .font(.answerTrueFalse)
                            .foregroundStyle(answered.isUserCorrect ? .positive: .negative)
                        Text(answered.explanation)
                            .font(.answer)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.answerBackground)
                    )
                    
                    if !appViewModel.thinkSolveLastRound {
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
                            appViewModel.thinkSolveNextQuestion()
                        }
                    } else {
                        
                        VStack {
                            Text("Dein Punktestand")
                                .font(.pointTitle)
                            Text("\(appViewModel.thinkSolveScore)")
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
                                    appViewModel.endThinkSolveRound(again: true)
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
                                    appViewModel.endThinkSolveRound(again: false)
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
        .padding()
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                GameDismissButton()
            }
        }
    }
}
