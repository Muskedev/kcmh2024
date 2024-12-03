//  PopViewHelper.swift
//  HirnOderHumbug
//
//  Created by Nico on 03.12.24.
//  
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func popView<Content: View>(
            isPresented: Binding<Bool>,
            onDismiss: @escaping () -> (),
            @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .modifier(PopViewHelper(
                        isPresented: isPresented,
                        onDismiss: onDismiss,
                        viewContent: content))
    }
}

fileprivate struct PopViewHelper<ViewContent: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    var onDismiss: () -> ()
    @ViewBuilder var viewContent: ViewContent
    
    @State private var presentFullScreenCover: Bool = false
    @State private var animateView: Bool = false
    @State private var animateBackground: Bool = false
    
    func body(content: Content) -> some View {
        let screenHeigt = screenSize.height
        let animateView = animateView
        let animateBackground = animateBackground
        
        content
            .fullScreenCover(isPresented: $presentFullScreenCover, onDismiss: onDismiss) {
                ZStack {
                    Color.clear.background(Color.black.opacity(animateBackground ? 0.4 : 0)).ignoresSafeArea()
                    viewContent
                        .visualEffect({ content, proxy in
                            content
                                .offset(y: offset(proxy, screenHeight: screenHeigt, animateView: animateView))
                        })
                        .presentationBackground(.clear)
                        .task {
                            guard !animateView else { return }
                            withAnimation(.bouncy(duration: 0.4, extraBounce: 0.05)) {
                                self.animateView = true
                            }
                        }
                        .task {
                            guard !animateBackground else { return }
                            withAnimation(.easeIn) {
                                self.animateBackground = true
                            }
                        }
                }
            }
            .onChange(of: isPresented) { oldValue, newValue in
                if newValue {
                    toggleView(true)
                } else {
                    Task {
                        withAnimation(.snappy(duration: 0.45, extraBounce: 0)) {
                            self.animateView = false
                        }
                        try? await Task.sleep(for: .seconds(0.45))
                    }
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

#Preview {
    @Previewable @State var isPresented = false
    Button("Test") {
        isPresented = true
    }
    .popView(isPresented: $isPresented, onDismiss: {
        print("")
    }) {
        VStack {
            Text("Hello World")
            Button("Close") {
                isPresented = false
            }
        }
    }
}
