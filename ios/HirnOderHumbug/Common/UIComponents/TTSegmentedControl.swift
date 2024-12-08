//
//  TTSegmentedControl.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 07.12.24.
//

import SwiftUI

enum TTSegment: Int, CaseIterable {
    case allLeader
    case reallyLeader
    case thinkSolveLeader
    case reallyHistory
    case thinkSolveHistory

    var title: String {
        switch self {
        case .allLeader: "Alle"
        case .reallyLeader: "Really?"
        case .thinkSolveLeader: "Think & Solve"
        case .reallyHistory: "Really"
        case .thinkSolveHistory: "Think & Solve"
        }
    }
    
    var gameMode: GameMode {
        switch self {
        case .reallyLeader, .reallyHistory: .really
        default: .thinkSolve
        }
    }
    
    static var leaders: [Self] {
        [.allLeader, .reallyLeader, .thinkSolveLeader]
    }
    
    static var history: [Self] {
        [.reallyHistory, .thinkSolveHistory]
    }
}

struct SegmentedControl<Indicator: View>: View {
    var tabs: [TTSegment]
    @Binding var activeTab: TTSegment
    var height: CGFloat = 45
    
    var font: Font = .segmentFont
    var activeTint: Color
    var inActiveTint: Color
    
    @ViewBuilder var indicatorView: (CGSize) -> Indicator
    
    @State private var excessTabWidth: CGFloat = .zero
    @State private var minX: CGFloat = .zero
    
    let tapCallback: () -> Void
    
    var body: some View {
        GeometryReader { reader in
            let size = reader.size
            let containerWidth = size.width / CGFloat(tabs.count)
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.rawValue) { tab in
                    Group {
                        Text(tab.title)
                    }
                    .font(font)
                    .foregroundStyle(activeTab == tab ? activeTint: inActiveTint)
                    .animation(.snappy, value: activeTab)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(.rect)
                    .onTapGesture {
                        if let index = tabs.firstIndex(of: tab), let activeIndex = tabs.firstIndex(of: activeTab) {
                            activeTab = tab
                            tapCallback()
                            withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                                excessTabWidth = containerWidth * CGFloat(index - activeIndex)
                            } completion: {
                                withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                                    minX = containerWidth * CGFloat(index)
                                    excessTabWidth = 0
                                }
                            }
                        }
                    }
                    .background(alignment: .leading) {
                        if tabs.first == tab {
                            GeometryReader {
                                let size = $0.size
                                indicatorView(size)
                                    .frame(width: size.width + (excessTabWidth < 0 ? -excessTabWidth: excessTabWidth), height: size.height)
                                    .frame(width: size.width, alignment: excessTabWidth < 0 ? .trailing: .leading)
                                    .offset(x: minX)
                            }
                        }
                    }
                }
            }
        }
        .frame(height: height)
    }
}

struct TestView: View {
    
    @State private var activeLeader: TTSegment = .allLeader
    @State private var activeHistory: TTSegment = .reallyHistory
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                SegmentedControl(tabs: TTSegment.leaders, activeTab: $activeLeader, height: 35, activeTint: .backgroundTwo, inActiveTint: .backgroundTwo.opacity(0.5)) { size in
                    Rectangle()
                        .fill(.blue)
                        .frame(height: 4)
                        .padding(.horizontal, 10)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                } tapCallback: {}
                
                SegmentedControl(tabs: TTSegment.history, activeTab: $activeHistory, height: 35, activeTint: .backgroundTwo, inActiveTint: .backgroundTwo.opacity(0.5)) { size in
                    Rectangle()
                        .fill(.blue)
                        .frame(height: 4)
                        .padding(.horizontal, 10)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                } tapCallback: {}
                
                Spacer(minLength: 0)
            }
            .navigationTitle("Segmented Control")
        }
    }
}


