//
//  GameScene.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 10.12.2023.
//

import SpriteKit
import SwiftUI

// Assigning a Binary Number Identifier to Each Instance of the Game

struct InstanceCategory{
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
    static let player: UInt32 = 0b1 // 1
    static let asteroid: UInt32 = 0b10 // 2
    static let crater: UInt32 = 0b11 // 3
    static let bananaPlantArea: UInt32 = 0b100 // 4
}

// Class GameScene Keeps Track of the Game Variables

class GameScene: SKScene{
    var gameLogic: GameLogic = GameLogic.shared
}

// Game Scene Set Up
extension GameScene{
    
    private func setUpGame() {
        self.gameLogic.setUpGame()
    }
}
