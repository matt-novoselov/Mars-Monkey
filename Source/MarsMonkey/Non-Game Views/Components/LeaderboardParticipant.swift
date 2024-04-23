//
//  LeaderboardParticipant.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 22/04/24.
//

import SwiftUI

// This structure is used for displaying single user in leaderboard
struct leaderboardParticipant: View {
    var playerName: String = "Player Name"
    var playerScore: Int = 0
    var place: Int = 0
    var isHighlighted: Bool = false
    
    var body: some View {
        ZStack{
            Rectangle()
                .padding(.horizontal, -50)
                .ignoresSafeArea()
                .frame(height: 65)
                .foregroundColor(.white)
                .opacity(isHighlighted ? 1 : 0)
            
            HStack(spacing: 10){
                Group{
                    StrokeText(text: place.description, strokeWidth: 1)
                        .frame(width: 30, alignment: .leading)
                                    
                    StrokeText(text: playerName, strokeWidth: 1)
                    
                    Spacer()
                    
                    Image(.palmTree)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 35)
                    
                    StrokeText(text: playerScore.description, strokeWidth: 1)
                        .frame(alignment: .trailing)
                }
                .foregroundColor(isHighlighted ? .mmPink : .white)
                .font(Font.custom("RedBurger", size: 20))
            }
        }
    }
}

#Preview {
    leaderboardParticipant(playerName: "Player 1", playerScore: 100, place: 0, isHighlighted: true)
}
