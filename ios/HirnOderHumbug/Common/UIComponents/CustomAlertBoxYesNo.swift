//  CustomAlertBoxYesNo.swift
//  HirnOderHumbug
//
//  Created by Nico on 03.12.24.
//  
//

import SwiftUI

struct CustomAlertBoxYesNo: View {
    
    let message: LocalizedStringKey
    
    var body: some View {
        VStack {
            Text(message)
                .font(.alertText)
            HStack {
                Text("Yes")
                    .modifier(AlertButtonStyle(color: .white, backgroundColor: .backgroundTwo))
                    .button {
                        
                    }
                
                Text("No")
                    .modifier(AlertButtonStyle(color: .white, backgroundColor: .backgroundThree))
                    .button {
                        
                    }
            }
        }
        .frame(width: 250)
        .padding([.horizontal, .bottom], 25)
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(.background)
                .padding(.top, 25)
        }
    }
}

#Preview("Only View") {
    CustomAlertBoxYesNo(message: "Hello World")
}

#Preview("Real") {
    @Previewable @State var isPresented: Bool = false
    Button("Action") {
        isPresented = true
    }
    .popView(isPresented: $isPresented, onDismiss: {
        print("Hello World")
    }) {
        CustomAlertBoxYesNo(message: "Hello World")
    }
}
