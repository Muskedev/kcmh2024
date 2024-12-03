//
//  ContentView.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct MainView: View {
    
    @State private var activeTab: CustomTabItem = .really
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $activeTab) {
                ForEach(CustomTabItem.allCases, id: \.self) { tab in
                    Tab.init(value: tab) {
                        tab.view
                            .toolbarVisibility(.hidden, for: .tabBar)
                    }
                }
            }
            
            FloatingTab(activeTab: $activeTab)
        }
        .overlay(alignment: .top) {
            BlurBackgroundView()
        }
    }
}

#Preview {
    MainView()
}
