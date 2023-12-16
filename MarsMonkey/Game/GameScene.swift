//
//  GameScene.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 10.12.2023.
//

import SpriteKit
import AVFoundation

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
    
    let crater = SKSpriteNode(imageNamed: "crater")
    
    let plantingArea = SKSpriteNode(imageNamed: "planting spot")
    
    var shouldRunAction = true
    
    var 🕹️: Joystick = Joystick(radius: 150) // Creating a joystick
    var joystickPosX: CGFloat = 0 // var representing how far the joystick was dragged on X axis
    var joystickPosY: CGFloat = 0 // var representing how far the joystick was dragged on Y axis
    
    // Create a shape node with the initial circle path
    let circleNode = SKShapeNode()
    
    // The trim factor controls how much of the circle is filled (0 = not filled, 1 = fully filled)
    var trimFactor: Double = 0 {
        didSet {
            // Ensure trimFactor stays within the valid range
            trimFactor = max(0, min(1, trimFactor))
            updateCirclePath()
        }
    }
    
    var backgroundMusicPlayer: AVAudioPlayer?
    
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
        self.setUpProgressBar()
        self.startPlantingAreaCycle()
        self.setUpInitialObstacles()
        self.playBackgroundMusic(filename: "Background_music.mp3")
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        self.joystickUpdate()
        self.playerUpdate()
        self.cameraUpdate()
        self.backgroundUpdate()
    }
}

// Game Scene Set Up
extension GameScene{
    private func setUpGame() {
        self.gameLogic.setUpGame()
        self.physicsWorld.contactDelegate = self
        self.scene?.size = CGSize(width: 1179, height: 2556) // Set scene's resolution
        self.startAsteroidsCycle()
        self.startCratersCycle()
    }
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -1.4)
        physicsWorld.contactDelegate = self
    }
    
    private func setUpInitialObstacles() {
        let initialXplantingArea: CGFloat = crater.size.width/2
        let finalXplantingArea: CGFloat = self.frame.width - crater.size.width/2
        let positionXplantingArea = CGFloat.random(in: initialXplantingArea...finalXplantingArea)
        
        let initialXcrater: CGFloat = crater.size.width/2
        let finalXcrater: CGFloat = self.frame.width - crater.size.width/2
        let positionXcrater = CGFloat.random(in: initialXcrater...finalXcrater)
        
        self.addChild(self.newPlantingArea(at: CGPoint(x: positionXplantingArea, y: frame.height/1.5)))
        self.newCrater(at: CGPoint(x: positionXcrater, y: frame.height - 400))
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
    
    func didEnd(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        // Check if either body is nil
        guard let nodeA = bodyA.node, let nodeB = bodyB.node else {
            return
        }
        
        // Check if one of the bodies is the player and the other is a planting area
        if (bodyA.categoryBitMask == InstanceCategory.player && bodyB.categoryBitMask == InstanceCategory.bananaPlantArea) ||
            (bodyA.categoryBitMask == InstanceCategory.bananaPlantArea && bodyB.categoryBitMask == InstanceCategory.player) {
            // Handle contact end
            handleContactEnd(plantingArea: bodyA.categoryBitMask == InstanceCategory.bananaPlantArea ? nodeA : nodeB)
        }
    }
}

extension GameScene {
    
    // Function to display pop-up text with fade-out, upward movement, and black stroke
    func showPopupText(text: String, at position: CGPoint, nodeName: String) {
        
        // Label for the text
        let popupLabel = SKLabelNode()
        
        // Set up the text attributes
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "RedBurger", size: 100)!,
            .foregroundColor: (nodeName == "planting spot") ? SKColor.greenTree : SKColor.red,
            .strokeWidth: -3.0,
            .strokeColor: SKColor.black
        ]
        
        // Create an attributed string with the specified attributes
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        
        // Set the attributed text to the label
        popupLabel.attributedText = attributedText
        
        // Set other properties
        popupLabel.position = position
        popupLabel.zPosition = player.zPosition
        
        // Add label to the scene
        addChild(popupLabel)
        
        // Action to fade out and move label upwards after 1 second
        let fadeOutAndMoveAction = SKAction.group([
            SKAction.fadeOut(withDuration: 1.0),
            SKAction.moveBy(x: 0, y: 50, duration: 1.0)
        ])
        
        // Action to remove label from parent
        let removeFromParentAction = SKAction.removeFromParent()
        
        // Sequence to combine fade-out, move, and remove actions
        let sequenceAction = SKAction.sequence([
            fadeOutAndMoveAction,
            removeFromParentAction
        ])
        
        popupLabel.run(sequenceAction)
    }
}



