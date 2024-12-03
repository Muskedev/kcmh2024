//  EnvironmentValues.swift
//  HirnOderHumbug
//
//  Created by Nico on 03.12.24.
//  
//

import SwiftUI

private struct ShowAlert: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var showAlert: Binding<Bool> {
        get { self[ShowAlert.self] }
        set { self[ShowAlert.self] = newValue }
    }
}
