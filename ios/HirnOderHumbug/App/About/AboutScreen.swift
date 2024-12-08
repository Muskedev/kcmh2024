//
//  AboutScreen.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 03.12.24.
//

import SwiftUI

struct AboutScreen: View {
    @Environment(\.appViewModel) var appViewModel
    
    var story: String = """
    Brian Brain hat einen einzigartigen Sinn für Humor und eine grenzenlose Neugier. Statt sich nur mit den großen Fragen des Lebens zu beschäftigen, verliebte er sich in das "unnütze Wissen" – die kleinen Details, die die Welt seltsam und wunderbar machen.

    Sein Ziel: Er will sein Wissen teilen – aber nicht einfach so! Mit Rätseln und Quizfragen fordert er dich heraus, denn er weiß: Nur wer selbst nachdenkt, behält das Wissen wirklich.

    Brian glaubt, dass jeder Tag besser wird, wenn wir etwas Neues lernen – egal, wie verrückt oder nutzlos es scheint. Ein Funfact kann ein Gespräch starten, ein Lächeln zaubern oder zeigen, wie wundervoll seltsam die Welt ist.

    Deshalb hat Brian mit den MuskeDevs diese Quiz-App erschaffen. Aus seinem digitalen Gehirn-Labor stellt er dir Fragen – nicht, um dich bloßzustellen, sondern um dich auf eine unterhaltsame Reise durch das Universum des unnützen Wissens mitzunehmen. Er liebt es, wenn du lachst, den Kopf schüttelst oder laut „Really?!“ rufst.
    """
    
    var body: some View {
        ZStack {
            BHMesh()
            
            VStack {
                BrightonHeader(head: "About", subhead: "Wer hat das hier verbrochen? 🤔\n\nEine wilde Mischung aus Nachteulen, Kaffee-Junkies und chronischen Scherzbolden. Wir haben diese App gebaut, weil wir dachten, die Welt braucht mehr Chaos in Frageform. Wenn du sie magst, sind wir Genies. Wenn nicht, war’s ein Unfall – wie die meisten unserer Ideen. Viel Spaß!")
                
                ScrollView {
                    LazyVStack {
                        
                        HStack(alignment: .top) {
                            Image(.brighton)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(.circle)
                                .clipped()

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Brian Brain")
                                    .font(.aboutUsName)
                                Text(story)
                                    .font(.historyDate)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20.0)
                                .fill(.aboutUsBackground)
                        )
                        .padding(.bottom, 5)
                        
                        ForEach(AboutMember.allCases.shuffled(), id: \.rawValue) { member in
                            ProfilRow(image: member.rawValue, name: member.name, role: member.function)
                        }
                        Text("Account zurücksetzen")
                        .font(.custom("Mabook", size: 22))
                        .foregroundStyle(.negative)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 20.0)
                                .fill(.white.opacity(0.3))
                        )
                        .button {
                            KeychainHelper.shared.reset()
                            appViewModel.noUser = true
                            appViewModel.showAlert = true
                        }
                    }
                }
                .safeAreaInset(edge: .bottom, content: {
                    Color.clear.frame(height: 80)
                })
                .scrollIndicators(.hidden)
                
                Spacer()
                .buttonStyle(.plain)
                .foregroundStyle(.red.mix(with: .black, by: 0.3))
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
        HStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(.circle)
                .clipped()

            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.aboutUsName)
                Text(role)
                    .font(.aboutUsRole)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .multilineTextAlignment(.leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20.0)
                .fill(.aboutUsBackground)
        )
        .padding(.bottom, 5)
    }
}

#Preview {
    AboutScreen()
}
