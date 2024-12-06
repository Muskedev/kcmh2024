//
//  ContentView.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.valueStore) private var valueStore
    @State private var activeTab: CustomTabItem = .really
    
    var body: some View {
        
        @Bindable var valueStore = valueStore
        
        ZStack(alignment: .bottom) {
            TabView(selection: $activeTab) {
                ForEach(CustomTabItem.allCases, id: \.self) { tab in
                    Tab.init(value: tab) {
                        tab.view
                            .toolbarVisibility(.hidden, for: .tabBar)
                    }
                }
            }
            .alertView(isPresented: $valueStore.noUser) {
                CreateUserAlert()
                    .padding()
            }
            
            FloatingTab(activeTab: $activeTab)
        }
        .onAppear {
            let id = KeychainHelper.shared.userId ?? ""
            valueStore.noUser = id.isEmpty
            valueStore.showAlert = valueStore.noUser
        }
        .overlay(alignment: .top) {
            BlurBackgroundView()
        }
    }
}

#Preview {
    MainView()
}
