//
//  SpeachBubble.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI

struct SpeechBubble: Shape {
    
    private let radius: CGFloat

    init(radius: CGFloat = 10) {
        self.radius = radius
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let cornerRadius: CGFloat = 12
        let arrowWidth: CGFloat = 20
        let arrowHeight: CGFloat = 10
        
        path.move(to: CGPoint(x: cornerRadius, y: 0))
        path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: 0))
        path.addArc(center: CGPoint(x: rect.width - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - cornerRadius - arrowHeight))
        path.addArc(center: CGPoint(x: rect.width - cornerRadius, y: rect.height - cornerRadius - arrowHeight), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.width / 2 + arrowWidth / 2, y: rect.height - arrowHeight))
        path.addLine(to: CGPoint(x: rect.width / 2, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width / 2 - arrowWidth / 2, y: rect.height - arrowHeight))
        path.addLine(to: CGPoint(x: cornerRadius, y: rect.height - arrowHeight))
        path.addArc(center: CGPoint(x: cornerRadius, y: rect.height - cornerRadius - arrowHeight), radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
        path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        
        return path
    }
}
