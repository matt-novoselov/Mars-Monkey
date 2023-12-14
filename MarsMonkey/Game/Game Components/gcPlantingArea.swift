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
        plantingArea.setScale(0.35)
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
        
        print("Contacted with planting area")
        
        if plantingArea.name == "planting spot" {
            
            let waitAction = SKAction.wait(forDuration: TimeInterval(GameConstants().bananaTreeSecondsToPlant))
            let addNodeAction = SKAction.run {
                // Delete the Asteroid from the Scene
                plantingArea.removeFromParent()
                
                // Spawn a banana Tree
                self.spawnBananaTree(plantingAreaPosition: plantingArea.position)
                
                // Add a Haptic Effect
                self.gameLogic.scoreIncreaseByOne(points: 1)
                self.timerModel.modifyTimer(by: self.gameConstants.bananaTreeRewardSeconds)
            }
            
            let sequenceAction = SKAction.sequence([waitAction, addNodeAction])
            run(sequenceAction)
        }
    }
    
    func spawnBananaTree(plantingAreaPosition: CGPoint){
        let palmTree = SKSpriteNode(imageNamed: "Palm Tree")
        palmTree.setScale(0.8)
        palmTree.zPosition = player.zPosition - 1
        palmTree.position = CGPoint(x: plantingAreaPosition.x, y: plantingAreaPosition.y+palmTree.size.width/2)
        addChild(palmTree)
    }
}
