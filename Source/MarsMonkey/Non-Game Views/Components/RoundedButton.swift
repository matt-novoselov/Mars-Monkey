//
//  RoundedButton.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 22/04/24.
//

import SwiftUI

// This structure is used to create a round button with a custom action
struct RoundedButton: View {
    
    var title: String
    var fontSize: CGFloat = 40
    var action: () -> Void
    
    var body: some View {
        Button(action: {action(); lightHaptic()}){
            StrokeText(text: title, strokeWidth: 1)
                .font(Font.custom("RedBurger", size: fontSize))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(.mmPinkButton)
                .cornerRadius(90)
        }
        .buttonStyle(PressEffectButtonStyle())
    }
    
}

// This structure is used to create an animation for buttons
struct PressEffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

#Preview {
    RoundedButton(title: "Test", action: {})
}
