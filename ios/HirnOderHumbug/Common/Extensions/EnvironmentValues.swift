//  EnvironmentValues.swift
//  HirnOderHumbug
//
//  Created by Nico on 03.12.24.
//  
//

import SwiftUI

extension EnvironmentValues {
    @Entry var valueStore: EnvironmentValuesStore = .init()
    @Entry var reallyViewModel: ReallyViewModel = .init()
}


