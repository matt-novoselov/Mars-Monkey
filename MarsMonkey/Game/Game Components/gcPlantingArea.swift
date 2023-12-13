//
//  gcCraters.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 13.12.2023.
//

import SpriteKit

extension GameScene{
    func createPlantingArea() {
        let plantingAreaPosition = CGPoint(x: self.scene!.frame.width/2, y: self.scene!.frame.height/2 + 400)
        newPlantingArea(at: plantingAreaPosition)
    }
    
    private func newPlantingArea(at position: CGPoint) {
        let plantingArea = SKSpriteNode(imageNamed: "planting spot")
        plantingArea.name = "planting spot"
        plantingArea.setScale(2)
        plantingArea.zPosition = player.zPosition
        plantingArea.position = position
        
        plantingArea.physicsBody = SKPhysicsBody(circleOfRadius: plantingArea.size.width/2)
        plantingArea.physicsBody?.affectedByGravity = false
        plantingArea.physicsBody?.allowsRotation = false
        plantingArea.physicsBody?.pinned = true
        
        plantingArea.physicsBody?.categoryBitMask = InstanceCategory.bananaPlantArea
        plantingArea.physicsBody?.contactTestBitMask = InstanceCategory.player
        
        addChild(plantingArea)
    }
}

// Handling the Contact of the Planting Area with the Player
extension GameScene{
    func handlePlantingAreaContact(plantingArea: SKNode) {
        // When Planting Area Contacts With a Player
        
        if plantingArea.name == "planting spot" {
            // Delete the Asteroid from the Scene
            plantingArea.removeFromParent()
            // Add a Haptic Effect
            gameLogic.scoreIncreaseByOne(points: 1)
            timerModel.modifyTimer(by: gameConstants.bananaTreeRewardSeconds)
        }
    }
}
