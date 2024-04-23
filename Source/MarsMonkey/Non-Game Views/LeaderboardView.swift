//
//  LeaderboardView.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 08/12/23.
//

import SwiftUI
import SwiftData

// Leaderboard View of the game
struct LeaderboardView: View {
    
    // Current game state, which can be menu, playing, timeIsUp, leaderboard
    @Binding var currentGameState: GameState
    
    // Saved player nave for user defaults
    @AppStorage("savedPlayerName") var savedPlayerName: String = ""
    
    // Initialize game constants file
    let gameConstants: GameConstants = GameConstants()
    
    // SwiftData model context
    @Environment(\.modelContext) private var context
    @Query private var items: [MyDataItem]
    
    var body: some View {
        VStack(spacing: 20){
            
            // Leaderboard title
            StrokeText(text: "Leaderboard", strokeWidth: 1)
                .font(Font.custom("RedBurger", size: 40))
                .foregroundColor(.mmPink)

            // Main leaderboard
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0){
                    ForEach(Array(ordinatedItems(items: items).enumerated()), id: \.1.id) { index, item in
                        leaderboardParticipant(
                            playerName: item.name,
                            playerScore: Int(item.score) ?? 0,
                            place: index + 1,
                            isHighlighted: savedPlayerName==item.name
                        )
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
            .background(.mmPink)
            .mask(RoundedRectangle(cornerRadius: 10))
            
            // Back to menu button
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
        .modelContainer(for: MyDataItem.self)
}
