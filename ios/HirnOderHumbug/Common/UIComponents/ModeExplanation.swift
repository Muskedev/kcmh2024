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
    @State private var progress: Bool = false
    @State var rotation = 0.0
    
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
                                    .padding(10)
                                    .background() {
                                        ZStack {
                                            GeometryReader { reader in
                                                Circle()
                                                    .fill(AngularGradient(stops: [
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
                                                    ))
                                                    .rotationEffect(.degrees(rotation))
                                                    .onAppear() {
                                                        withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                                                            rotation = 360
                                                        }
                                                    }
                                                    .frame(width: max(reader.size.width, reader.size.height) * 2, height: max(reader.size.width, reader.size.height) * 2)
                                                    .offset(x: -1 * max(reader.size.width, reader.size.height) / 2, y: -1 * (max(reader.size.width, reader.size.height) / 2))
                                            }
                                        }
                                        .clipShape(Capsule())
                                        .blur(radius: 3)
                                    }
                                Capsule()
                                    .fill(.white)
                                    .padding(10)

                            }
                        )
                        .button {
                            router.navigate(to: .start(mode))
                        }
                        .padding(.bottom, 80)
                }
                .padding()
            }
        }
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
/*
#Preview {
    @Previewable @State var rotation = 0.0
    Capsule()
        .fill(.white)
        .frame(maxWidth: 200, maxHeight: 80)
        .padding(10)
        .background() {
            ZStack {
                GeometryReader { reader in
                    Circle()
                        .fill(AngularGradient(stops: [
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
                        ))
                        .rotationEffect(.degrees(rotation))
                        .onAppear() {
                            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                                rotation = 360
                            }
                        }
                        .frame(width: max(reader.size.width, reader.size.height) * 2, height: max(reader.size.width, reader.size.height) * 2)
                        .offset(x: -1 * max(reader.size.width, reader.size.height) / 2, y: -1 * (max(reader.size.width, reader.size.height) / 2 + 40))
                }
            }
            .clipShape(Capsule())
            .blur(radius: 3)
        }
}
*/

#Preview {
    ModeExplanation(mode: .really)
}
