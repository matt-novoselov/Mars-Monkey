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
    case leaderboard // LeaderboardView
}

struct GameConstants{
    let isDebug: Bool = false
    // - - - - SPEED - - - - //
    
    // Players speed in pixels
    let playerSpeed: CGFloat = 1.5
    
    // Players speed in pixels
    let cameraMovementSpeed: CGFloat = 3.2
    
    // - - - - TIMER - - - - //
    
    // Timer Constant
    let timerDurationInSeconds: Int = 120
    
    // Amount of seconds to spend to plant a banana tree
    let bananaTreeSecondsToPlant: Int = 3
    
    // - - - - IMPACT SCORE - - - - //
    
    // Amount of seconds subtracted from the timer after touching a crater
    let decrementSecondsNumber: Int = -10
    
    // Amount of seconds added to the timer after planting a banana tree
    let bananaTreeRewardSeconds: Int = 10
    
    // - - - - COLLISION CHEAT - - - - //
    
    // Amount of seconds subtracted from the timer after touching a crater
    let collisionCheat: Double = 0.8
    
    // - - - - OBJECTS GENERATION CONSTRAINTS - - - - //
    
    let maxNumberOfCratersInARow = 2
    
    let cratersGenerationIntervalInSeconds: Double = 4
    
    let minDistanceBetweenPlantingAreas: CGFloat = 2000
}

// - - - - INSTANCE CATEGORY - - - - //

// Assigning a Binary Number Identifier to Each Instance of the Game
struct InstanceCategory{
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
    static let player: UInt32 = 0b1 // 1
    static let asteroid: UInt32 = 0b10 // 2
    static let crater: UInt32 = 0b11 // 3
    static let bananaPlantArea: UInt32 = 0b100 // 4
}
