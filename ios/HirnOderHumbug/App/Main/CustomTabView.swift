//  TabView.swift
//  HirnOderHumbug
//
//  Created by Nico on 02.12.24.
//  
//

import SwiftUI
import SwiftChameleon

private enum CustomTabItem: Int, CaseIterable {
    
    case tabOne
    case tabTwo
    
    var caption: String {
        switch self {
        case .tabOne:
            GameMode.really.name
        case .tabTwo:
            GameMode.thinkSolve.name
        }
    }
    
    var icon: String {
        switch self {
        case .tabOne:
            "checkmark.circle.badge.xmark"
        case .tabTwo:
            "questionmark.bubble"
        }
    }
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .tabOne:
            ModeExplanation(mode: .really)
        case .tabTwo:
            ModeExplanation(mode: .thinkSolve)
        }
    }
}

struct CustomTabView: View {
    
    @State private var selectedTab: CustomTabItem = CustomTabItem.tabOne
    
    var body: some View {
        ZStack {
            selectedTab.view
            
            VStack {
                Spacer()
                HStack {
                    ForEach(CustomTabItem.allCases, id: \.self) { tabItem in
                        CTabItem(tabItem: tabItem, isActive: selectedTab == tabItem)
                            .button {
                                selectedTab = tabItem
                            }
                    }
                }
                .padding(6)
                .frame(height: 70)
                .background(.white)
                .cornerRadius(35)
                .padding(.horizontal, 26)
            }
        }
    }
}

private struct CTabItem: View {

    let tabItem: CustomTabItem
    let isActive: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Spacer()
            Image(systemName: tabItem.icon)
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
            if isActive{
                Text(tabItem.caption.translate)
                    .font(.system(size: 14))
            }
            Spacer()
        }
        .foregroundStyle(isActive ? .white : .gray)
        .frame(maxWidth: isActive ? .infinity : 60)
        .frame(height: 60)
        .if(isActive, { content in
            content
                .background(.backgroundThree.opacity(0.7).gradient)
        })
        .cornerRadius(30)
    }
}

#Preview {
    CustomTabView()
}
