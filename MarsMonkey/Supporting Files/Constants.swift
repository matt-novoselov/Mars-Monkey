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
    
    // Timer Constant
    let timerDurationInSeconds: Int = 120
    
    // Amount of seconds subtracted from the timer after touching a crater
    let craterImpactSeconds: Int = -10
    
    // Amount of seconds added to the timer after planting a banana tree
    let bananaTreeRewardSeconds: Int = 10
    
    // Amount of seconds to spend to plant a banana tree
    let bananaTreeSecondsToPlant: Int = 3
}