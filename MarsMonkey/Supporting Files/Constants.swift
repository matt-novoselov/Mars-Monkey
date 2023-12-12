//
//  Constants.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 10.12.2023.
//

import Foundation
import SwiftUI

enum GameState{
    case menu // MenuView
    case playing // GameView
    case timeIsUp // TimesUpView
    case redLineIsHit // GameOverView
    case leaderboard // LeaderboardView
}

struct GameConstants{
    // Disable on release
    let isDebugging = false
    
    
    // - - - - SPEED - - - - //
    
    // Players speed in pixels
    let playerSpeed: CGFloat = 1
    
    // Players speed in pixels
    let cameraMovementSpeed: CGFloat = 1
    
    // - - - - TIMER - - - - //
    
    // Timer Constant
    let timerDurationInSeconds: Int = 20 // 120
    
    // Amount of seconds to spend to plant a banana tree
    let bananaTreeSecondsToPlant: Int = 3
    
    // - - - - IMPACT SCORE - - - - //
    
    // Amount of seconds subtracted from the timer after touching a crater
    let decrementSecondsNumber: Int = 10
    
    // Amount of seconds added to the timer after planting a banana tree
    let bananaTreeRewardSeconds: Int = 10
}
