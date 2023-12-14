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
        plantingArea.setScale(0.45)
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
            shouldRunAction = true
            plantingArea.addChild(circleNode)
            
            // Run the animation
            animateTrimFactor()

            let waitAction = SKAction.wait(forDuration: TimeInterval(gameConstants.bananaTreeSecondsToPlant))
            let addNodeAction = SKAction.run { [weak self] in
                // Check if shouldRunAction is true before executing the block
                guard let self = self, self.shouldRunAction else { return }

                // Spawn a banana Tree
                self.spawnBananaTree(plantingAreaPosition: plantingArea.position)

                // Add a Haptic Effect
                self.gameLogic.scoreIncreaseByOne(points: 1)
                self.timerModel.modifyTimer(by: self.gameConstants.bananaTreeRewardSeconds)

                // Delete the Asteroid from the Scene
                plantingArea.removeFromParent()
            }

            let sequenceAction = SKAction.sequence([waitAction, addNodeAction])
            
            if self.shouldRunAction{
                run(sequenceAction)
            }
        }
    }
    
    
    // Function to handle contact end
    func handleContactEnd(plantingArea: SKNode) {
        // Your code to handle the end of contact with a planting area
        
        if plantingArea.name == "planting spot" {
            // Add any specific actions you want to perform when the contact ends
            shouldRunAction = false
            plantingArea.removeAllChildren()
            trimFactor = 0
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
