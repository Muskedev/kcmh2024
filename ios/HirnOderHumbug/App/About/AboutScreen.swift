//
//  AboutScreen.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 03.12.24.
//

import SwiftUI

struct AboutScreen: View {
    var body: some View {
        ZStack {
            BHMesh()
            
            VStack {
                BrightonHeader(head: "About", subhead: "Wer hat das hier verbrochen? 🤔\n\nEine wilde Mischung aus Nachteulen, Kaffee-Junkies und chronischen Scherzbolden. Wir haben diese App gebaut, weil wir dachten, die Welt braucht mehr Chaos in Frageform. Wenn du sie magst, sind wir Genies. Wenn nicht, war’s ein Unfall – wie die meisten unserer Ideen. Viel Spaß!")
                
                ScrollView {
                    LazyVStack {
                        ProfilRow(image: "imagesimon", name: "Simon", role: "War halt auch dabei!")
                        ProfilRow(image: "imagemia", name: "Mia", role: "War halt auch dabei!")
                        ProfilRow(image: "imagesephi", name: "Sephi", role: "War halt auch dabei!")
                        ProfilRow(image: "imagenico", name: "Simon", role: "War halt auch dabei!")
                        ProfilRow(image: "imagenico", name: "Simon", role: "War halt auch dabei!")
                        ProfilRow(image: "imagenico", name: "Simon", role: "War halt auch dabei!")
                    }
                }
                .safeAreaInset(edge: .bottom, content: {
                    Color.clear.frame(height: 80)
                })
                .scrollIndicators(.hidden)
                
                Spacer()
            }
            .padding()
        }
    }
}

private struct ProfilRow: View {
    
    let image: String
    let name: String
    let role: String
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(.circle)
                        .clipped()

                    VStack(alignment: .leading) {
                        Text(name)
                            .font(Font.aboutUsName)
                        Text("War halt auch dabei")
                            .font(Font.aboutUsRole)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .multilineTextAlignment(.leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20.0)
                    .fill(.aboutUsBackground)
            )
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    AboutScreen()
}
