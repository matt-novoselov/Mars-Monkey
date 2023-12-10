//
//  GameLogic.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 10.12.2023.
//

import Foundation

class GameLogic: ObservableObject{
    
    // Variable Used To Transfer the Values of Variables from this File to Other Files
    static let shared: GameLogic = GameLogic()
    
    // Sets Values of Variables at the Beginning of the Game
    func setUpGame(){
        
        self.currentScore = 0
        self.isTimeUp = false
        self.isRedLineHit = false
        
    }
    
    // Variable Used to Store the Current Score of the Player
    @Published var currentScore: Int = 0
    
    // Increases the Score by One
    func scoreIncreaseByOne(points: Int) {

        self.currentScore += 1
    }
    
    // Game Finishing Conditions:
    
    // 1. Hitting Red Line
    
    @Published var isRedLineHit: Bool = false
    
    func finishTheGameWhenRedLineHit() {
        if self.isRedLineHit == false {
            self.isRedLineHit = true
        }
    }
    
    // 2. Running out of Time
    
    @Published var isTimeUp: Bool = false
    func finishTheGameWhenTimeIsUp() {
        if self.isTimeUp == false {
            self.isTimeUp = true
        }
    }
}
