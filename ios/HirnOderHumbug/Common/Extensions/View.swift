//
//  View.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 04.12.24.
//

import SwiftUI

extension View {
    
    /// Add custom alert view to view
    ///
    /// - Parameters:
    ///     - isPresented: Binding value if the Alert should be presented
    ///     - onDismiss: The action call when dismissed
    ///     - content: The view of the alert
    /// - Returns: the alert view
    func alertView<Content: View>(
        isPresented: Binding<Bool>,
        onDismiss: @escaping () -> Void = {},
        content: @escaping () -> Content
    ) -> some View {
        modifier(
            PopViewHelper(
                isPresented: isPresented,
                onDismiss: onDismiss,
                viewContent: content
            )
        )
    }
}
