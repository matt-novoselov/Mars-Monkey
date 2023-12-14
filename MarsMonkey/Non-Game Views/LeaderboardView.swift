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
    
    
    func addAndCheckItem(playerName: String, score: String){
        if let index = items.firstIndex(where: {item in
            item.name == playerName})
        {
            if (Int(items[index].score) ?? 0 < Int(score) ?? 0){
                items[index].score = score
                try? context.save()
            }
        }
        else{
            let newItem = MyDataItem(name: playerName, score: score)
            context.insert(newItem)
        }
        
    }
    
    func ordinatedItems() -> [MyDataItem] {
        var sortedItems: [MyDataItem] {
            return items.sorted { Int($0.score) ?? 0 > Int($1.score) ?? 0 }
        }
        
        return sortedItems
    }
    
    var body: some View {
        if gameConstants.isDebug{
            Button("Add a random record") {
                addAndCheckItem(playerName: "Player\(String(Int.random(in: 1...100)))", score: String(Int.random(in: 1...100)))
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
                        ForEach(Array(ordinatedItems().enumerated()), id: \.1.id) { index, item in
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
