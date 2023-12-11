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
    let background = SKSpriteNode(imageNamed: "Mars Background")
    
    let cam = SKCameraNode()
    
    var 🕹️: Joystick = Joystick(radius: 150) // Creating a joystick
    var joystickPosX: CGFloat = 0 // var representing how far the joystick was dragged on X axis
    var joystickPosY: CGFloat = 0 // var representing how far the joystick was dragged on Y axis
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        scene?.size = CGSize(width: 1179, height: 2556) // Set scene's resolution
        
        self.setUpGame() // Set up game in GameLogic's function
        self.setUpPhysicsWorld() // Set up PhysicsWorld
        
        background.anchorPoint = CGPointZero
        background.position = CGPointMake(0, background.size.height - 1)
        background.zPosition = -15
        self.addChild(background)

        addChild(🕹️)
        addChild(🕹️.child)
        
        player.position = CGPoint(x: size.width/2, y: size.height/2)
        player.zPosition = 10
        player.setScale(0.05)
        player.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        player.physicsBody?.affectedByGravity = false
        
        // Setting CollisionBitMask, CategoryBitMask and ContactBitMask for a Player
        player.physicsBody?.collisionBitMask = InstanceCategory.player
        player.physicsBody?.categoryBitMask = InstanceCategory.asteroid
        player.physicsBody?.contactTestBitMask = InstanceCategory.asteroid
        
        addChild(player)

        cam.position = player.position
        self.camera = cam
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
        if gameLogic.secondsLeft == 0{
            gameLogic.finishTheGameWhenTimeIsUp()
        }
        
        🕹️.position = CGPoint(x: scene!.frame.width/2, y: cam.position.y - scene!.frame.height/3) // Set position of the joystick
        
        if !🕹️.isActive{
            🕹️.child.position = CGPoint(x: 🕹️.position.x, y: 🕹️.position.y) // Set position of the joystick's child
        }

        // Limit player's movement on X and Y axis
        let xRange = SKRange(lowerLimit: 35, upperLimit: frame.width - 35)
        let xConstraint = SKConstraint.positionX(xRange)
        let yRange = SKRange(lowerLimit: cam.position.y - scene!.frame.height/2 + 50, upperLimit: cam.position.y + scene!.frame.height/2 - 50)
        let yConstraint = SKConstraint.positionY(yRange)
        self.player.constraints = [xConstraint, yConstraint]
        
        cam.position.y += GameConstants().cameraMovementSpeed
        
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
        self.startAsteroidsCycle()
    }
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.9)
        physicsWorld.contactDelegate = self
    }
}

// Asteroids Creation
extension GameScene {
    
    private func createAsteroid() {
        let asteroidPosition = self.randomAsteroidPosition()
        newAsteroid(at: asteroidPosition)
    }
    
    private func randomAsteroidPosition() -> CGPoint {
        let initialX: CGFloat = 25
        let finalX: CGFloat = self.frame.width - 25
        
        let positionX = CGFloat.random(in: initialX...finalX)
        let positionY = cam.position.y + frame.height / 2 + 50
        
        return CGPoint(x: positionX, y: positionY)
    }
    
    private func newAsteroid(at position: CGPoint) {
        let newAsteroid = SKSpriteNode(imageNamed: "asteroid")
        newAsteroid.name = "asteroid"
        newAsteroid.setScale(0.25)
        newAsteroid.zPosition = player.zPosition
        newAsteroid.position = position
        
        newAsteroid.physicsBody = SKPhysicsBody(circleOfRadius: 25.0)
        newAsteroid.physicsBody?.affectedByGravity = true
        
        newAsteroid.physicsBody?.categoryBitMask = InstanceCategory.asteroid
        newAsteroid.physicsBody?.contactTestBitMask = InstanceCategory.player
        newAsteroid.physicsBody?.collisionBitMask = InstanceCategory.player
        
        addChild(newAsteroid)
        
        newAsteroid.run(SKAction.sequence([
            SKAction.wait(forDuration: 5.0),
            SKAction.removeFromParent()
        ]))
    }
    
}

// Asteroids Cycle
extension GameScene{
    func startAsteroidsCycle() {
        let createAsteroidAction = SKAction.run(createAsteroid)
        let waitAction = SKAction.wait(forDuration: 5.0)
        
        let createAndWaitAction = SKAction.sequence([createAsteroidAction, waitAction])
        let asteroidCycleAction = SKAction.repeatForever(createAndWaitAction)
        
        run(asteroidCycleAction)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        let asteroidNode = contact.bodyA.node?.name == "asteroid" ? contact.bodyA.node : contact.bodyB.node

        if let asteroid = asteroidNode {
            asteroid.removeFromParent()
            print("Asteroid removed due to contact with the player.")
        }
    }
}
