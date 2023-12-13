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

    let redLine = SKSpriteNode(imageNamed: "RedLine")
    
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
        self.setUpRedLine()
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        self.joystickUpdate()
        self.playerUpdate()
        self.cameraUpdate()
        self.backgroundUpdate()
        self.redLineUpdate()

        if timerModel.secondsLeft == 0{
            gameLogic.finishTheGameWhenTimeIsUp()
        }
    }
}

// Game Scene Set Up
extension GameScene{
    private func setUpGame() {
        self.gameLogic.setUpGame()
        self.startAsteroidsCycle()
        self.physicsWorld.contactDelegate = self
        self.scene?.size = CGSize(width: 1179, height: 2556) // Set scene's resolution
        self.createCrater()
    }
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -1.4)
        physicsWorld.contactDelegate = self
    }
}
