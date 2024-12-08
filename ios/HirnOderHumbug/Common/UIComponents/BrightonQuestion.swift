//
//  BrightonQuestion.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct BrightonQuestion: View {
    
    @Environment(\.appViewModel) private var appViewModel
    var loadingStrings: [String] = [
        "Ich schalte meinen Hirn-Hamster auf Highspeed. 🐹",
        "Ich werfe mal die Denkmaschine an.",
        "Ich muss kurz mein Oberstübchen rebooten.",
        "Ich geh mal in die kreative Höhle.",
        "Ich lass die Ideen-Glühbirne flackern. 💡",
        "Ich starte einen Brainstorm im Oberdeck.",
        "Ich zapfe die Synapsen-Cloud an.",
        "Ich dreh am mentalen Ideen-Kaleidoskop.",
        "Ich schicke meinen Denkapparat ins Bootcamp.",
        "Ich mach mal ein Kopf-Kino mit neuen Szenen. 🎬"
    ]
    @State var loadingQuestion: String = ""
    let mode: GameMode
    
    var body: some View {
        @Bindable var appViewModel = appViewModel
        
        VStack {
            ZStack {
                if mode == .really {
                    if let question = appViewModel.reallyQuestion {
                        AnimatedText(question.question)
                            .font(.question)
                    } else {
                        VStack(spacing: 10.0) {
                            Image(systemName: "ellipsis")
                                .font(.largeTitle)
                                .foregroundStyle(.gray)
                                .symbolEffect(.wiggle.up.byLayer, options: .repeat(.continuous))
                            
                            Text(loadingQuestion)
                                .font(.answer)
                        }
                    }
                } else {
                    if let question = appViewModel.thinkSolveQuestion {
                        AnimatedText(question.question)
                            .font(.question)
                    } else {
                        VStack(spacing: 10.0) {
                            Image(systemName: "ellipsis")
                                .font(.largeTitle)
                                .foregroundStyle(.gray)
                                .symbolEffect(.wiggle.up.byLayer, options: .repeat(.continuous))
                            
                            Text(loadingQuestion)
                                .font(.answer)
                        }
                    }
                }
                
            }
            .padding(.top, 15)
            .padding(.bottom, 25)
            .padding(.horizontal, 30)
            .background(
                SpeechBubble()
                    .fill(.speechBubble)
            )
            
            Image(.brightonTransparent)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .animation(.spring) { view in
                    view.rotation3DEffect(.init(degrees: appViewModel.reallyAnswer ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                }
        }
        .onChange(of: appViewModel.reallyQuestion) { _,_ in
            loadingQuestion = loadingStrings.randomElement() ?? ""
        }
        .onChange(of: appViewModel.thinkSolveQuestion) { _,_ in
            loadingQuestion = loadingStrings.randomElement() ?? ""
        }
        .onAppear {
            loadingQuestion = loadingStrings.randomElement() ?? ""
            if mode == .really {
                appViewModel.newReallyRound()
            } else {
                appViewModel.newThinkSolveRound()
            }
        }
    }
}
