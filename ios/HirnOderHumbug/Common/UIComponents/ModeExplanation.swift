//
//  QuestionMode.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct ModeExplanation: View {
    
    // MARK: - Properties
    let mode: GameMode
    @State var path: NavigationPath =  .init()
    
    // MARK: - Body
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                BrightonHeader(head: mode.name, subhead: mode.explanation)
                Spacer()
                
                Text("Start Game")
                    .modifier(TTButtonStyle(color: Color.backgroundOne))
                    .button {
                        path.append(1)
                    }
                
                Spacer()
            }
            .padding()
        }
    }
}
