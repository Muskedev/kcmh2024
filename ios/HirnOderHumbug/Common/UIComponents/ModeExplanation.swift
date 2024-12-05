//
//  QuestionMode.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 02.12.24.
//

import SwiftUI
import Routing

struct ModeExplanation: View {
    
    // MARK: - Properties
    let mode: GameMode
    @StateObject private var router: Router<GameRoute> = .init()
    @State private var progress1: Double = 0.0
    @State private var progress2: Double = 0.0
    
    // MARK: - Body
    var body: some View {
        RoutingView(stack: $router.stack) {
            ZStack {
                BHMesh()
                
                VStack(spacing: 30.0) {
                    VStack {
                        LabelView()
                    }
                    
                    Image(.brightonTransparent)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 150)
                    
                                       
                    VStack(alignment: .leading, spacing: 10) {
                        Text(mode.name)
                            .font(.brightonHead)
                        
                        Text(mode.explanation)
                            .font(.brightonSubhead)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 15)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.speechBubble)
                    )
                    
                    Text("Runde starten")
                        .font(.custom("Mabook", size: 28))
                        .padding(40.0)
                        .foregroundStyle(.backgroundTwo)
                        .background(
                            ZStack {
                                Capsule()
                                    .fill(.white)
                                
                                ProgressView(progress: progress1)
                                ProgressView(progress: progress2)
                                    .rotationEffect(.degrees(180.0))

                            }
                        )
                        .button {
                            router.navigate(to: .start(mode))
                        }
                        .padding(.bottom, 80)
                }
                .padding()
                .onAppear() {
                    withAnimation(
                        .linear(duration: 2.0)
                        .repeatForever(autoreverses: false)
                    ) {
                        progress1 = 1.0
                    }
                    
                    withAnimation(
                        .linear(duration: 2.0)
                        .repeatForever(autoreverses: false)
                        .delay(1.0)
                    ) {
                        progress2 = 1.0
                    }
                }
            }
        }
    }
}

struct ProgressView: View, Animatable {
  var progress: Double
    private let delay = 0.5

  var animatableData: Double {
    get { progress }
    set { progress = newValue }
  }

  var body: some View {
    Capsule()
          .trim(
            from: {
              if progress > delay {
                progress - delay
              } else {
                .zero
              }
            }(),
            to: {
                if progress > 0.5 {
                    0.5
              } else {
                progress
              }
            }()
          )
      .glow(
        fill: .angularGradient(
            stops: [
              .init(color: .backgroundOne, location: 0.0),
              .init(color: .backgroundTwo, location: 0.2),
              .init(color: .positive, location: 0.4),
              .init(color: .backgroundOne, location: 0.5),
              .init(color: .backgroundTwo, location: 0.7),
              .init(color: .positive, location: 0.9),
              .init(color: .backgroundOne, location: 1.0),
            ],
            center: .center,
            startAngle: Angle(radians: .zero),
            endAngle: Angle(radians: .pi * 2)
          ),
        lineWidth: 8.0
      )
  }
}

struct LabelView: View {
  var body: some View {
      VStack(spacing: 10) {
          Text("Willkommen in")
          Text("Brians BrainLab")
      }
      .font(.custom("Mabook", size: 42))
      .foregroundStyle(.white)
      .bold()
      .fontWidth(.expanded)
  }
}
