//
//  GameOverView.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 09.12.2023.
//

import SwiftUI

struct GameOverView: View {
    
        @Binding var currentGameState: GameState
        
        var amountOfBananasPlanted: Int
        
        var body: some View {
            VStack(spacing: 20){
                StrokeText(text: "Game over!", strokeWidth: 1)
                    .font(Font.custom("RedBurger", size: 48))
                    .foregroundColor(.white)
                
                Image("coffin")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                StrokeText(text: "You've planted \(amountOfBananasPlanted) banana trees and died", strokeWidth: 1)
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
    GameOverView(currentGameState: .constant(GameState.redLineIsHit), amountOfBananasPlanted: 10)
}
