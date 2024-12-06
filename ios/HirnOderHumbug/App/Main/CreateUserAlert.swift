//
//  CreateUserAlert.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 05.12.24.
//

import SwiftUI

struct CreateUserAlert: View {
    
    @Environment(\.appViewModel) private var appViewModel
    
    var body: some View {
        @Bindable var appViewModel = appViewModel
        
        VStack(spacing: 15) {
            BrightonHeader(head: "Willkommen bei Brians BrainLab!", subhead: "Mit wem hab ich es eigentlich hier zu tun?")
            
            TextField("Name eingeben", text: $appViewModel.userName)
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
                .button {
                    appViewModel.createUser()
                }
            
        }
        .padding()
        .background(
            BHMesh()
                .clipShape(.rect(cornerRadius: 15.0))
        )
    }
}
