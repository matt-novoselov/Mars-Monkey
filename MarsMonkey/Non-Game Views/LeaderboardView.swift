//
//  LeaderboardView.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 08/12/23.
//

import SwiftUI

struct LeaderboardView: View {
    
    @Binding var currentGameState: GameState
    
    var body: some View {
        VStack(spacing: 20){
            StrokeText(text: "Leaderboard", strokeWidth: 1)
                .font(Font.custom("RedBurger", size: 40))
                .foregroundColor(.mmPink)

            ZStack {
                Color(.mmPink).edgesIgnoringSafeArea(.bottom)
                    .cornerRadius(10)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0){
                        ForEach((1...15), id: \.self) { place in
                            leaderboardParticipant(
                                place: place,
                                isHighlighted: place == 5 ? true : false
                            )
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .mask(RoundedRectangle(cornerRadius: 10))
            
            roundedButton(title: "Menu", fontSize: 24, action: {
                withAnimation { self.currentGameState = .menu }
            })
        }
        .padding(.horizontal, 45)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mmUIBackground)
    }
}

#Preview {
    LeaderboardView(currentGameState: .constant(GameState.leaderboard))
}
