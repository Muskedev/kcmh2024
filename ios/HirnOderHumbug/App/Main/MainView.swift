//
//  ContentView.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct MainView: View {
    
    @State private var clickedTrue: Bool = true
    let opacity: CGFloat = 0.7
    
    var body: some View {
        NavigationStack {
            ZStack {
                BHMesh()
                CustomTabView()
            }
        }
    }
}

#Preview {
    MainView()
}
