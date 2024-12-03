//
//  AboutScreen.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 03.12.24.
//

import SwiftUI

struct AboutScreen: View {
    var body: some View {
        VStack {
            BrightonHeader(head: "About", subhead: "Wer hat das hier verbrochen? 🤔\n\nEine wilde Mischung aus Nachteulen, Kaffee-Junkies und chronischen Scherzbolden. Wir haben diese App gebaut, weil wir dachten, die Welt braucht mehr Chaos in Frageform. Wenn du sie magst, sind wir Genies. Wenn nicht, war’s ein Unfall – wie die meisten unserer Ideen. Viel Spaß!")
            
            Spacer()
        }
        .padding()
    }
}
