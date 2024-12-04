//  BlurBackgroundView.swift
//  HirnOderHumbug
//
//  Created by Nico on 03.12.24.
//  
//

import SwiftUI

struct BlurBackgroundView: View {
    
    @Environment(\.valueStore) private var valueStore
    
    var body: some View {
        Color.clear
            .background(.ultraThinMaterial)
            .ignoresSafeArea()
            .opacity(valueStore.showAlert ? 1: 0.0)
            .animation(
                .easeInOut(duration: 0.3),
                value: valueStore.showAlert
            )
    }
}
