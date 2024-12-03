//  CustomAlertBoxYesNo.swift
//  HirnOderHumbug
//
//  Created by Nico on 03.12.24.
//  
//

import SwiftUI

struct CustomAlertBoxYesNo: View {
    
    @Environment(\.dismiss) private var dismiss
    let message: LocalizedStringKey
    let action: (Bool) -> ()
    
    init(_ message: LocalizedStringKey, action: @escaping (Bool) -> Void) {
        self.message = message
        self.action = action
    }
    
    var body: some View {
        VStack {
            Text(message)
                .font(.alertText)
                .padding(.bottom, 40)
            HStack {
                Text("Ja")
                    .modifier(AlertButtonStyle(color: .white, backgroundColor: .backgroundTwo))
                    .button {
                        dismiss()
                        action(true)
                    }
                
                Text("Nein")
                    .modifier(AlertButtonStyle(color: .white, backgroundColor: .backgroundThree))
                    .button {
                        dismiss()
                        action(false)
                    }
            }
        }
        .frame(width: 250)
        .padding(25)
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(.background)
        }
    }
}

#Preview("Only View") {
    CustomAlertBoxYesNo("Hello World", action: { value in
        print(value)
    })
}

#Preview("Real") {
    @Previewable @State var isPresented: Bool = false
    Button("Action") {
        isPresented = true
    }
    .popView(isPresented: $isPresented, onDismiss: {
        
    }) {
        CustomAlertBoxYesNo("Hello World", action: { value in
            print(value)
        })
    }
}
