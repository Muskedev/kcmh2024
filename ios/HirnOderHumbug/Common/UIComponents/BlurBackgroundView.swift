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
        Color.black.opacity(showAlert.wrappedValue ? 0.3 : 0).ignoresSafeArea()
    }
}

#Preview {
    BlurBackgroundView()
}

#Preview("Blur") {
    BlurBackgroundView()
        .environment(\.showAlert, .constant(true))
}

