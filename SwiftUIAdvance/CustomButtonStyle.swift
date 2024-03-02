//
//  ButtonStyle.swift
//  SwiftUIAdvance
//
//  Created by loratech on 02/03/24.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    
    let scaledAmount: CGFloat
    
    init(scaledAmount: CGFloat) {
        self.scaledAmount = scaledAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
//            .brightness(configuration.isPressed ? 0.05 : 0)
            
    }
}

extension View {
    func withPressableStyle(scaledAmount: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount))
    }
}

struct CustomButtonStyle: View {
    var body: some View {
        Button(action: {
            print("Button pressed!")
        }, label: {
            Text("Click Me!")
                .font(.headline)
                .withDefaultButtonFormatting()
        })
        .withPressableStyle()
        .padding(40)
    }
}

#Preview {
    CustomButtonStyle()
}
