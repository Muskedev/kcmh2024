//
//  HirnOderHumbugApp.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

@main
struct HirnOderHumbugApp: App {
    
    @State private var valueStore: EnvironmentValuesStore = .init()
    @State private var reallyViewModel: ReallyViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.valueStore, valueStore)
                .environment(\.reallyViewModel, reallyViewModel)
        }
    }
}
