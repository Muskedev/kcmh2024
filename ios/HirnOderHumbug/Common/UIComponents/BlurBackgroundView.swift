//  BlurBackgroundView.swift
//  HirnOderHumbug
//
//  Created by Nico on 03.12.24.
//  
//

import SwiftUI

struct BlurBackgroundView: View {
    
    @Environment(\.appViewModel) private var appViewModel
    
    var body: some View {
        Color.clear
            .background(.ultraThinMaterial)
            .ignoresSafeArea()
            .opacity(appViewModel.showAlert ? 1: 0.0)
            .animation(
                .easeInOut(duration: 0.3),
                value: appViewModel.showAlert
            )
    }
}
