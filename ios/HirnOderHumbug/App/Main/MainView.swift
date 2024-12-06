//
//  ContentView.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.appViewModel) private var appViewModel
    @State private var activeTab: CustomTabItem = .really
    
    var body: some View {
        
        @Bindable var appViewModel = appViewModel
        
        ZStack(alignment: .bottom) {
            TabView(selection: $activeTab) {
                ForEach(CustomTabItem.allCases, id: \.self) { tab in
                    Tab.init(value: tab) {
                        tab.view
                            .toolbarVisibility(.hidden, for: .tabBar)
                            .ignoresSafeArea()
                    }
                }
            }
            .alertView(isPresented: $appViewModel.noUser) {
                CreateUserAlert()
                    .padding()
            }
            
            FloatingTab(activeTab: $activeTab)
        }
        .onAppear {
            appViewModel.checkUserExists()
        }
        .overlay(alignment: .top) {
            BlurBackgroundView()
        }
    }
}

#Preview {
    MainView()
}
