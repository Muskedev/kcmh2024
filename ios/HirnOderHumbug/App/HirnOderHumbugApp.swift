//
//  HirnOderHumbugApp.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

@main
struct HirnOderHumbugApp: App {
    
    @State private var showAlert: Bool = false
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.showAlert, $showAlert)
        }
    }
}
