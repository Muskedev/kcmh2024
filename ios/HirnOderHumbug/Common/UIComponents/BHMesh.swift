//
//  BHMesh.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct BHMesh: View {
    
    let opacity: CGFloat = 0.7
    
    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                .init(0, 0), .init(0.5, 0), .init(1, 0),
                .init(0, 0.5), .init(0.3, 0.5), .init(1, 0.5),
                .init(0, 1), .init(0.5, 1), .init(1, 1)
            ],
            colors: [
                .backgroundOne.opacity(opacity), .backgroundOne.opacity(opacity), .backgroundOne.opacity(opacity),
                .backgroundTwo.opacity(opacity), .backgroundTwo.opacity(opacity), .backgroundTwo.opacity(opacity),
                .backgroundThree.opacity(opacity), .backgroundThree.opacity(opacity), .backgroundThree.opacity(opacity)
            ]
        )
        .ignoresSafeArea()
    }
}
