//
//  GameView.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 10.12.2023.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var gameLogic: GameLogic = GameLogic.shared
    
    @Binding var currentGameState: GameState
    
    var body: some View {
        ZStack(alignment: .top){
            // SpriteKit staff
            Text("GameView")
                .frame(maxHeight: .infinity)
            
            // UI overlay elements
            HStack{
                GameTimer(secondsLeft: 146)
                
                Spacer()
                
                GameScore(currentScore: 10)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    GameView(currentGameState: .constant(GameState.playing))
}
