//  BlurBackgroundView.swift
//  HirnOderHumbug
//
//  Created by Nico on 03.12.24.
//  
//

import SwiftUI

struct BlurBackgroundView: View {
    
    @Environment(\.showAlert) var showAlert
    
    var body: some View {
        Color.clear
            .background(.ultraThinMaterial)
            .ignoresSafeArea()
            .opacity(showAlert.wrappedValue ? 1: 0.0)
            .animation(
                .easeInOut(
                    duration: 0.6
                ),
                value: showAlert.wrappedValue
            )
    }
}
