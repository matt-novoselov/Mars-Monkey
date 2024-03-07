//
//  LeaderboardView.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 08/12/23.
//

import SwiftUI
import SwiftData

struct LeaderboardView: View {
    @Binding var currentGameState: GameState
    @AppStorage("savedPlayerName") var savedPlayerName: String = ""
    let gameConstants: GameConstants = GameConstants() // Initialize game constants file
    
    @Environment(\.modelContext) private var context
    @Query private var items: [MyDataItem]
    
    var body: some View {
        if gameConstants.isDebug{
            Button("Add a random record") {
                let requestResult = addAndCheckItem(playerName: "Player\(String(Int.random(in: 1...100)))", score: String(Int.random(in: 1...100)), items: items)
                
                if requestResult.name == "nil" && requestResult.score == "nil" {
                    try? context.save()
                }
                else{
                    context.insert(requestResult)
                }
            }
        }
        
        VStack(spacing: 20){
            StrokeText(text: "Leaderboard", strokeWidth: 1)
                .font(Font.custom("RedBurger", size: 40))
                .foregroundColor(.mmPink)
            
            ZStack {
                Color(.mmPink).edgesIgnoringSafeArea(.bottom)
                    .cornerRadius(10)
                
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
        .modelContainer(for: MyDataItem.self)
}
