//
//  ContentView.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.appViewModel) private var appViewModel
    @State private var activeTab: CustomTabItem = .history
    @State private var isKeyboardVisible: Bool = false
    
    var body: some View {
        
        @Bindable var appViewModel = appViewModel
        
        ZStack(alignment: .bottom) {
            TabView(selection: $activeTab) {
                ForEach(CustomTabItem.allCases, id: \.self) { tab in
                    Tab.init(value: tab) {
                        tab.view
                            .toolbarVisibility(.hidden, for: .tabBar)
                            .ignoresSafeArea(.all, edges: .bottom)
                    }
                }
            }
            .alertView(isPresented: $appViewModel.noUser) {
                CreateUserAlert()
                    .padding()
            }
            
            if !isKeyboardVisible {
                FloatingTab(activeTab: $activeTab)
            }
        }
        .onAppear {
            appViewModel.checkUserExists()
            addKeyboardObservers()
        }
        .overlay(alignment: .top) {
            BlurBackgroundView()
        }
    }
    
    // MARK: - Keyboard Observers
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
            withAnimation {
                isKeyboardVisible = true
            }
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            withAnimation {
                isKeyboardVisible = false
            }
        }
    }

    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
