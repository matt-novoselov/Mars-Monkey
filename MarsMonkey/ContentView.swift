//
//  ContentView.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 10/12/23.
//

import SwiftUI


/**
 * # ContentView
 *
 *   This view is responsible for managing the states of the game, presenting the proper view.
 **/

struct ContentView: View {
    
    // The navigation of the app is based on the state of the game.
    // Each state presents a different view on the SwiftUI app structure
    @State var currentGameState: GameState = .menu
    
    // The game logic is a singleton object shared among the different views of the application
    @StateObject var gameLogic: GameLogic = GameLogic()
    
    var body: some View {
        
        switch currentGameState {
            
        case .menu:
            MenuView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
            
        case .playing:
            GameView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
            
        case .timeIsUp:
            TimesUpView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
            
        case .leaderboard:
            LeaderboardView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: MyDataItem.self)
}
