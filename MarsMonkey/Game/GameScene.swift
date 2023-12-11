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
    
    let player = SKSpriteNode(imageNamed: "Monkey")
    
    var 🕹️: Joystick = Joystick(radius: 150) // Creating a joystick
    var joystickPosX: CGFloat = 0 // var representing how far the joystick was dragged on X axis
    var joystickPosY: CGFloat = 0 // var representing how far the joystick was dragged on Y axis
    
    override func didMove(to view: SKView) {
        scene?.size = CGSize(width: 1179, height: 2556) // Set scene's resolution
        
        self.setUpGame() // Set up game in GameLogic's function
        
        backgroundColor = .mmUIBackground
        
        🕹️.position = CGPoint(x: scene!.frame.width/2, y: scene!.frame.height/5) // Set position of the joystick
        🕹️.child.position = CGPoint(x: scene!.frame.width/2, y: scene!.frame.height/5) // Set position of the joystick's child
        addChild(🕹️)
        addChild(🕹️.child)
        
        player.position = CGPoint(x: size.width/2, y: size.height/2)
        player.zPosition = 10
        player.setScale(0.05)
        
        // Limit player's movement on X axis
        let xRange = SKRange(lowerLimit: 0 + 25, upperLimit: frame.width - 25)
        let xConstraint = SKConstraint.positionX(xRange)
        self.player.constraints = [xConstraint]
        
        addChild(player)
    }
    
    // Joystick becomes active after user touches the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !🕹️.isActive {
            🕹️.isActive = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if 🕹️.isActive {
                // All mathematical logic is performed in the "getDist" function
                let dist = 🕹️.getDist(withLocation: location)
                
                //Divide the speed by 32 to decrease the speed
                joystickPosX = dist.xDist / 32
                joystickPosY = dist.yDist / 32
            }
        }
    }
    
    // Joystick becomes inactive after user untouches the screen
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if 🕹️.isActive {
            //When the touch ends the central button of the joystick returns to the initial position and speed
            🕹️.coreReturn()
            joystickPosX = 0
            joystickPosY = 0
        }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        
        //Update players position based on the joystick's movement
        if 🕹️.isActive {
            player.position = CGPoint(x: player.position.x - (joystickPosX * GameConstants().playerSpeed),
                                      y: player.position.y + (joystickPosY * GameConstants().playerSpeed))
        }
    }
    
}

// Game Scene Set Up
extension GameScene{
    private func setUpGame() {
        self.gameLogic.setUpGame()
    }
}
