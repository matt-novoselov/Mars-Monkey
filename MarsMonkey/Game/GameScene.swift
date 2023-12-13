//
//  GameScene.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 10.12.2023.
//

import SpriteKit
import SwiftUI


// Class GameScene Keeps Track of the Game Variables
class GameScene: SKScene{
    var gameLogic: GameLogic = GameLogic.shared // Link to the GameLogic file, where all calculations should be performed
    let gameConstants: GameConstants = GameConstants() // Initialize game constants file
        
    var timerModel: TimerModel
    
    let player = SKSpriteNode(imageNamed: "Monkey")
    
    let background = SKSpriteNode(imageNamed: "Mars Background")
    let background2 = SKSpriteNode(imageNamed: "Mars Background")
    var amountOfCycles: Int = 0
    
    let cam = SKCameraNode()

    var 🕹️: Joystick = Joystick(radius: 150) // Creating a joystick
    var joystickPosX: CGFloat = 0 // var representing how far the joystick was dragged on X axis
    var joystickPosY: CGFloat = 0 // var representing how far the joystick was dragged on Y axis
    
    
    // initialization function for GameScene
    init(timerModel: TimerModel) {
        self.timerModel = timerModel
        super.init(size: CGSize(width: 1179, height: 2556))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // Set up game first time
    override func didMove(to view: SKView) {
        self.setUpGame() // Set up game in GameLogic's function
        self.setUpPhysicsWorld() // Set up PhysicsWorld
        self.setUpJoystick()
        self.setUpPlayer()
        self.setUpCamera()
        self.setUpBackground()
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        self.joystickUpdate()
        self.playerUpdate()
        self.cameraUpdate()
        self.backgroundUpdate()

        if timerModel.secondsLeft == 0{
            gameLogic.finishTheGameWhenTimeIsUp()
        }
    }
}

// Game Scene Set Up
extension GameScene{
    private func setUpGame() {
        self.gameLogic.setUpGame()
        self.physicsWorld.contactDelegate = self
        self.scene?.size = CGSize(width: 1179, height: 2556) // Set scene's resolution
        self.startAsteroidsCycle()
        self.createCrater()
        self.createPlantingArea()
    }
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -1.4)
        physicsWorld.contactDelegate = self
    }
}

// Registering the Contact of the Player With Objects (Craters, Asteroids, Planting Areas)
extension GameScene: SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        // Check if either body is nil
        guard let nodeA = bodyA.node, let nodeB = bodyB.node else {
            return
        }
        
        // Check if one of the bodies is the player and the other is an asteroid
        if (bodyA.categoryBitMask == InstanceCategory.player && bodyB.categoryBitMask == InstanceCategory.asteroid) ||
            (bodyA.categoryBitMask == InstanceCategory.asteroid && bodyB.categoryBitMask == InstanceCategory.player) {
            handleAsteroidContact(asteroid: bodyA.categoryBitMask == InstanceCategory.asteroid ? nodeA : nodeB)
        }
        
        // Check if one of the bodies is the player and the other is a crater
        if (bodyA.categoryBitMask == InstanceCategory.player && bodyB.categoryBitMask == InstanceCategory.crater) ||
            (bodyA.categoryBitMask == InstanceCategory.crater && bodyB.categoryBitMask == InstanceCategory.player) {
            // Handle crater contact
            handleCraterContact(crater: bodyA.categoryBitMask == InstanceCategory.crater ? nodeA : nodeB)
        }
        
        // Check if one of the bodies is the player and the other is a planting area
        if (bodyA.categoryBitMask == InstanceCategory.player && bodyB.categoryBitMask == InstanceCategory.bananaPlantArea) ||
            (bodyA.categoryBitMask == InstanceCategory.bananaPlantArea && bodyB.categoryBitMask == InstanceCategory.player) {
            // Handle crater contact
            handlePlantingAreaContact(plantingArea: bodyA.categoryBitMask == InstanceCategory.bananaPlantArea ? nodeA : nodeB)
        }
    }
    
}
