//
//  CreateUserAlert.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 05.12.24.
//

import SwiftUI

struct CreateUserAlert: View {
    
    @State private var username: String = ""
    
    var body: some View {
        VStack(spacing: 15) {
            BrightonHeader(head: "Willkommen bei TrickyTruth!", subhead: "Mit wem hab ich es eigentlich hier zu tun?")
            
            TextField("Name eingeben", text: $username)
                .padding(.horizontal, 30.0)
                .padding(.vertical, 15.0)
                .background(
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(.white)
                )
            
            Text("Erstellen")
                .font(.buttonNormal)
                .foregroundStyle(.backgroundTwo)
                .padding(.horizontal, 30)
                .padding(.vertical, 15.0)
                .background(
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(.white)
                )
            
        }
        .padding()
        .background(
            BHMesh()
                .clipShape(.rect(cornerRadius: 15.0))
        )
    }
}
