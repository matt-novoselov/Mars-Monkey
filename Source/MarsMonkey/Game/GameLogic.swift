//
//  GameLogic.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 10.12.2023.
//

import Foundation

class GameLogic: ObservableObject{
    let gameConstants: GameConstants = GameConstants()
    
    // Variable Used To Transfer the Values of Variables from this File to Other Files
    static let shared: GameLogic = GameLogic()
    
    // Sets Values of Variables at the Beginning of the Game
    func setUpGame(){
        self.currentScore = 0
        playerSpeedIncrementFactor = 1.00
        cameraSpeedIncrementFactor = 1.00
        self.isTimeUp = false
    }
    
    // Variable Used to Store the Current Score of the Player
    @Published var currentScore: Int = 0
    
    // Increases the Score by One
    func scoreIncreaseByOne(points: Int) {
        self.currentScore += 1
    }
    
    // Speed Increment Factor for the Speed of Player
    @Published var playerSpeedIncrementFactor: Double = 0
    
    // Increases the Speed of Player
    func increasePlayerSpeedIncrementFactor(by number: Double) {
        self.playerSpeedIncrementFactor += number
    }
    
    // Speed Increment Factor for the Speed of Camera
    @Published var cameraSpeedIncrementFactor: Double = 0
    
    // Increases the Speed of Camera
    func increaseCameraSpeedIncrementFactor(by number: Double) {
        self.cameraSpeedIncrementFactor += number
    }
    
    // Game Finishing Conditions:
    
    @Published var isTimeUp: Bool = false
    func finishTheGameWhenTimeIsUp() -> GameState {
        if self.isTimeUp == false {
            self.isTimeUp = true
            print("The game was finished, because the timer expired")
            return GameState.timeIsUp
        }
        return GameState.playing
    }
}
