//
//  HistoryTSRow.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 04.12.24.
//

import SwiftUI

struct HistoryReallyRow: View {
    
    let question: FunfactsQuestion
    var wasCorrect: Bool { question.correctAnswer == question.userAnswer }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15.0) {
            
            Text(question.question)
                .font(.historyTitle)
                .foregroundStyle(.black)
            
            HStack {
                VStack(spacing: 5) {
                    Text(KeychainHelper.shared.userName ?? "")
                        .font(.historyButtonText)
                    Text(question.userAnswer ?? false ? "Wahr": "Falsch")
                        .font(.historyTrueFalse)
                        .foregroundStyle(question.userAnswer ?? false ? .positive: .negative)
                }
                .frame(maxWidth: .infinity)
                
                VStack(spacing: 5) {
                    Text("Brian Brain")
                        .font(.historyButtonText)
                    Text(question.correctAnswer ? "Wahr": "Falsch")
                        .font(.historyTrueFalse)
                        .foregroundStyle(question.correctAnswer ? .positive: .negative)
                }
                .frame(maxWidth: .infinity)
            }
            
            Text(
                """
                **Erklärung:**
                \(question.explanation)
                """
            )
            .font(.historyAnswer)
            .foregroundStyle(.black)
                
        }
        .multilineTextAlignment(.leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20.0)
                .fill(.white)
        )
        .padding(.bottom, 10)
    }
}

struct HistoryThinkSolveRow: View {
    
    let question: ThinkSolveQuestion
    var wasCorrect: Bool { question.correctAnswer ?? false }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15.0) {
            
            Text(question.question)
                .font(.historyTitle)
                .foregroundStyle(.black)
            
            VStack {
                VStack(spacing: 5) {
                    Text(KeychainHelper.shared.userName ?? "")
                        .font(.historyButtonText)
                    Text(question.userAnswer ?? "")
                        .font(.historyTitle)
                        .foregroundStyle(wasCorrect ? .positive: .negative)
                }
                .frame(maxWidth: .infinity)
            }
            
            Text(
                """
                **Erklärung:**
                \(question.explanation ?? "")
                """
            )
            .font(.historyAnswer)
            .foregroundStyle(.black)
                
        }
        .multilineTextAlignment(.leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20.0)
                .fill(.white)
        )
        .padding(.bottom, 10)
    }
}
