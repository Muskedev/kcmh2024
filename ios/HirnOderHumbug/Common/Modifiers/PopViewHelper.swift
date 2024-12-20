//
//  PopViewHelper.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 04.12.24.
//

import SwiftUI

struct PopViewHelper<ViewContent: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    var onDismiss: () -> ()
    @ViewBuilder var viewContent: ViewContent
    
    @State private var presentFullScreenCover: Bool = false
    @State private var animateView: Bool = false
    
    func body(content: Content) -> some View {
        let screenHeigt = screenSize.height
        let animateView = animateView
        
        content
            .fullScreenCover(isPresented: $presentFullScreenCover, onDismiss: onDismiss) {
                viewContent
                    .visualEffect({ content, proxy in
                        content
                            .offset(y: offset(proxy, screenHeight: screenHeigt, animateView: animateView))
                    })
                    .presentationBackground(.clear)
                    .task {
                        guard !animateView else { return }
                        withAnimation(.bouncy(duration: 0.45, extraBounce: 0.05)) {
                            self.animateView = true
                        }
                    }
            }
            .onChange(of: isPresented) { oldValue, newValue in
                guard newValue == false else {
                    toggleView(true)
                    return
                }
                
                Task {
                    withAnimation(.snappy(duration: 0.45, extraBounce: 0)) {
                        self.animateView = false
                    }
                    try? await Task.sleep(for: .seconds(0.45))
                    
                    toggleView(false)
                }
            }
    }
    
    nonisolated func offset(_ proxy: GeometryProxy, screenHeight: CGFloat, animateView: Bool) -> CGFloat {
        let viewHeight = proxy.size.height
        return animateView ? 0 : (viewHeight + screenHeight) / 2
    }
    
    var screenSize: CGSize {
        guard let screenSize = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds.size else { return .zero }
        return screenSize
    }
    
    func toggleView(_ status: Bool) {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        
        withTransaction(transaction) {
            presentFullScreenCover = status
        }
    }
}
