//
//  CreditsView.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 01/05/24.
//

import SwiftUI

// Leaderboard View of the game
struct CreditsView: View {
    
    // Current game state, which can be menu, playing, timeIsUp, leaderboard
    @Binding var currentGameState: GameState
    
    var body: some View {
        VStack(spacing: 20){
            
            // Leaderboard title
            StrokeText(text: "Credits", strokeWidth: 1)
                .font(Font.custom("RedBurger", size: 40))
                .foregroundColor(.mmPink)
            
            Spacer()
            
            StrokeText(text: "Programming", strokeWidth: 1)
                .font(Font.custom("RedBurger", size: 28))
                .foregroundColor(.mmPink)
            
            // Names of people
            Group{
                VStack(spacing: 5){
                    StrokeText(text: "Massimo Paloscia", strokeWidth: 1)
                    StrokeText(text: "Mariia Chemerys", strokeWidth: 1)
                    StrokeText(text: "Matt Novoselov", strokeWidth: 1)
                    StrokeText(text: "Gabriele Perillo", strokeWidth: 1)
                }
            }
            .font(Font.custom("RedBurger", size: 20))
            .foregroundColor(.white)
            
            StrokeText(text: "Design", strokeWidth: 1)
                .font(Font.custom("RedBurger", size: 28))
                .foregroundColor(.mmPink)
            
            // Names of people
            Group{
                VStack(spacing: 5){
                    StrokeText(text: "Mariia Chemerys", strokeWidth: 1)
                    StrokeText(text: "Matt Novoselov", strokeWidth: 1)
                    StrokeText(text: "Eugenio Renna", strokeWidth: 1)
                }
            }
            .font(Font.custom("RedBurger", size: 20))
            .foregroundColor(.white)
            
            Spacer()
            
            // Back to menu button
            RoundedButton(title: "Menu", fontSize: 24, action: {
                withAnimation { self.currentGameState = .menu }
            })
        }
        .padding(.horizontal, 45)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mmUIBackground)
    }
}

#Preview {
    CreditsView(currentGameState: .constant(.credits))
}

