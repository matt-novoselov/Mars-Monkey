//
//  GameView.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 10.12.2023.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @StateObject var gameLogic: GameLogic = GameLogic.shared
    
    @Binding var currentGameState: GameState
    
    var scene = GameScene()
    

    var body: some View {
        ZStack(alignment: .top){
            // SpriteKit staff
            
            SpriteView(
                scene: scene
                ,debugOptions: [.showsPhysics]
            )
            .ignoresSafeArea()
  
            // UI overlay elements
            HStack{
                TimerView()
                
                Spacer()
                
                Text(gameLogic.secondsLeft.description)
                    .opacity(GameConstants().isDebugging ? 1 : 0)
                
                GameScore(currentScore: gameLogic.currentScore)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    GameView(currentGameState: .constant(GameState.playing))
}
