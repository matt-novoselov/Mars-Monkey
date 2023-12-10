//
//  TimesUpView.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 08/12/23.
//

import SwiftUI

struct TimesUpView: View {
    
    @Binding var currentGameState: GameState
    
    var amountOfBananasPlanted: Int
    
    var body: some View {
        VStack(spacing: 20){
            StrokeText(text: "Time’s up!", strokeWidth: 1)
                .font(Font.custom("RedBurger", size: 48))
                .foregroundColor(.white)
            
            Image(.timesUpMonkey)
            
            StrokeText(text: "Congrats on planting \(amountOfBananasPlanted) banana trees", strokeWidth: 1)
                .font(Font.custom("RedBurger", size: 24))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            roundedButton(title: "Menu", fontSize: 24, action: {})
            
            roundedButton(title: "Leaderboard", fontSize: 24, action: {})
        }
        .padding()
        .background(.mmPink)
        .cornerRadius(10)
        .padding(.all, 40)
    }
}

#Preview {
    TimesUpView(currentGameState: .constant(GameState.timeIsUp), amountOfBananasPlanted: 10)
}