//
//  PlayerNameWarning.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 01/05/24.
//

import SwiftUI

// This View is presented when user tries to start the game without entering the name
struct PlayerNameWarning: View {
    
    @Binding var isWarningPresented: Bool
    
    var body: some View {
        
        // Compose card content
        VStack(spacing: 50){
            StrokeText(text: "Please, enter your name", strokeWidth: 1)
                .font(Font.custom("RedBurger", size: 24))
                .foregroundColor(.white)
            
            RoundedButton(title: "Okay", fontSize: 24, action: {
                withAnimation { isWarningPresented = false }
            })
        }
        // Compose background of the card
        .padding(.horizontal)
        .padding()
        .background(.mmPink)
        .cornerRadius(10)
        .padding()
        // Compose background
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.2))
        
    }
}

#Preview {
    PlayerNameWarning(isWarningPresented: .constant(true))
}
