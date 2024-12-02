//
//  ContentView.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    .init(0, 0), .init(0.5, 0), .init(1, 0),
                    .init(0, 0.5), .init(0.3, 0.5), .init(1, 0.5),
                    .init(0, 1), .init(0.5, 1), .init(1, 1)
                ],
                colors: [
                    Color(red: 0.19, green: 0.44, blue: 0.87), Color(red: 0.19, green: 0.44, blue: 0.87), Color(red: 0.19, green: 0.44, blue: 0.87),
                    Color(red: 0.25, green: 0.60, blue: 0.93), Color(red: 0.25, green: 0.60, blue: 0.93), Color(red: 0.25, green: 0.60, blue: 0.93),
                    Color(red: 0.10, green: 0.35, blue: 0.70), Color(red: 0.10, green: 0.35, blue: 0.70), Color(red: 0.10, green: 0.35, blue: 0.70)
                ]
            )
            .ignoresSafeArea()
            
            Image(.brightonTransparent)
                .resizable()
                .scaledToFit()
                .frame(width: 150)
        }
    }
}

#Preview {
    MainView()
}
