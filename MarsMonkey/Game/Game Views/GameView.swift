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
        Text("GameView")
    }
}

#Preview {
    GameView(currentGameState: .constant(GameState.playing))
}
