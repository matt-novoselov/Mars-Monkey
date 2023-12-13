//
//  gcCraters.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 12.12.2023.
//

import SpriteKit

extension GameScene{
    func createCrater() {
        let craterPosition = self.randomCraterPosition()
        newCrater(at: craterPosition)
    }
    
    private func randomCraterPosition() -> CGPoint {
        let initialX: CGFloat = 100
        let finalX: CGFloat = self.frame.width - 100
        
        let positionX = CGFloat.random(in: initialX...finalX)
        let positionY = cam.position.y + frame.height
        
        return CGPoint(x: positionX, y: positionY)
    }
    
    private func newCrater(at position: CGPoint) {
        let newCrater = SKSpriteNode(imageNamed: "crater")
        newCrater.name = "crater"
        newCrater.setScale(0.25)
        newCrater.zPosition = player.zPosition
        newCrater.position = position
        
        newCrater.physicsBody = SKPhysicsBody(circleOfRadius: newCrater.size.width/2)
        newCrater.physicsBody?.affectedByGravity = false
        newCrater.physicsBody?.allowsRotation = false
        newCrater.physicsBody?.pinned = true
        
        newCrater.physicsBody?.categoryBitMask = InstanceCategory.crater
        newCrater.physicsBody?.contactTestBitMask = InstanceCategory.player
        
        addChild(newCrater)
    }
}

// Handling the Contact of the Crater with the Player
extension GameScene{
    func handleCraterContact(crater: SKNode) {
        // When Asteroid Contacts With a Player
        if crater.name == "crater" {
            // Delete the Asteroid from the Scene
            crater.removeFromParent()
            // Add a Haptic Effect
            heavyHaptic()
            timerModel.modifyTimer(by: gameConstants.decrementSecondsNumber)
        }
    }
}
