//  TabView.swift
//  HirnOderHumbug
//
//  Created by Nico on 02.12.24.
//  
//

import SwiftUI
import SwiftChameleon

enum CustomTabItem: Int, CaseIterable {
    
    case tabOne
    case tabTwo
    
    var caption: String {
        switch self {
        case .tabOne:
            "TabEins"
        case .tabTwo:
            "TabZwei"
        }
    }
    
    var icon: String {
        switch self {
        case .tabOne:
            "person"
        case .tabTwo:
            "paperplane"
        }
    }
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .tabOne:
            XFQuestionView()
        case .tabTwo:
            GenialDanebenView()
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
                        CTabItem(tabItem: tabItem)
                            .button {
                                selectedTab = tabItem
                            }
                            .buttonStyle(.plain)
                            .bold(selectedTab == tabItem)
                    }
                }
            }
        }
    }
}

private struct CTabItem: View {

    let tabItem: CustomTabItem
    
    var body: some View {
        VStack {
            Image(systemName: tabItem.icon)
                .padding(.bottom, 5)
            Text(tabItem.caption)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    CustomTabView()
}
