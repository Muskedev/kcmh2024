//
//  FloatingTab.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 03.12.24.
//

import SwiftUI

struct FloatingTab: View {
   
    var activeForeground: Color = .white
    var activeBackground: Color = .backgroundThree.opacity(0.7)
    @Binding var activeTab: CustomTabItem
    
    @Namespace private var animation
    @State private var tabLocation: CGRect = .zero
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(CustomTabItem.allCases, id: \.rawValue) { tab in
                HStack(spacing: 5) {
                    if tab == .really || tab == .thinkSolve {
                        Text(tab == .really ? "😳": "🧠")
                            .font(.tabIcon)
                            .frame(height: 50)
                    } else {
                        Image(systemName: tab.icon)
                            .font(.tabIcon)
                            .frame(height: 50)
                    }
                    
                    if activeTab == tab {
                        Text(tab.caption)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                    }
                }
                .foregroundStyle(activeTab == tab ? activeForeground: .gray.opacity(0.8))
                .padding(.vertical, 2)
                .padding(.leading, 10)
                .padding(.trailing, 15)
                .contentShape(.rect)
                .background {
                    if activeTab == tab {
                        Capsule()
                            .fill(.clear)
                            .onGeometryChange(for: CGRect.self, of: {
                                $0.frame(in: .named("TABBAR_VIEW"))
                            }, action: { newValue in
                                tabLocation = newValue
                            })
                            .matchedGeometryEffect(id: "ACTIVE_TAB", in: animation)
                    }
                }
                .button {
                    activeTab = tab
                }
            }
        }
        .background(alignment: .leading, content: {
            Capsule()
                .fill(activeBackground.gradient)
                .frame(width: tabLocation.width, height: tabLocation.height)
                .offset(x: tabLocation.minX)
        })
        .coordinateSpace(.named("TABBAR_VIEW"))
        .padding(.horizontal, 5)
        .frame(height: 65)
        .background(
            .background
                .shadow(.drop(color: .black.opacity(0.2), radius: 5, x: 5, y: 5))
                .shadow(.drop(color: .black.opacity(0.12), radius: 5, x: -5, y: -5)),
            in: .capsule
        )
        .animation(.smooth(duration: 0.4, extraBounce: 0), value: activeTab)
    }
}
