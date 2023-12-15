//
//  gcPlantingArea.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 13.12.2023.
//

import SpriteKit

public var previousPlantingAreaPositions: [CGPoint] = []

extension GameScene{
    public func newPlantingArea(at position: CGPoint) -> SKSpriteNode{
        plantingArea.setScale(0.45)
        let newPlantingArea = SKSpriteNode(imageNamed: "planting spot")
        
        newPlantingArea.scale(to: plantingArea.size)
        newPlantingArea.name = "planting spot"
        newPlantingArea.zPosition = player.zPosition - 1
        newPlantingArea.position = position
        newPlantingArea.physicsBody = SKPhysicsBody(circleOfRadius: plantingArea.size.width/2)
        newPlantingArea.physicsBody?.affectedByGravity = false
        newPlantingArea.physicsBody?.allowsRotation = false
        newPlantingArea.physicsBody?.pinned = true
        
        newPlantingArea.physicsBody?.categoryBitMask = InstanceCategory.bananaPlantArea
        newPlantingArea.physicsBody?.contactTestBitMask = InstanceCategory.player
        
        return newPlantingArea
    }
    
    func createPlantingArea() {
        let newPlantingArea: SKSpriteNode = newPlantingArea(at: randomPlantingAreaPosition())

        if !isOverlappingWithPreviousCraters(position: newPlantingArea.position) && !isAreaFarAway(position: newPlantingArea.position){
            previousPlantingAreaPositions.append(newPlantingArea.position)
            addChild(newPlantingArea)
        }
    }
    
    func handlePlantingAreaContact(plantingArea: SKNode) {
        // When Planting Area Contacts With a Player
        
        if plantingArea.name == "planting spot" {
            if let spriteNode = plantingArea as? SKSpriteNode {
                let newTexture = SKTexture(imageNamed: "planting spot pressed")
                spriteNode.texture = newTexture
            }
            
            lightHaptic()
            
            shouldRunAction = true
            trimFactor = 0
            plantingArea.addChild(circleNode)
            
            // Run the animation
            animateTrimFactor()
            
            let waitAction = SKAction.wait(forDuration: TimeInterval(gameConstants.bananaTreeSecondsToPlant))
            let addNodeAction = SKAction.run { [weak self] in
                // Check if shouldRunAction is true before executing the block
                guard let self = self, self.shouldRunAction && trimFactor >= 0.99 else { return }
                
                // Spawn a banana Tree
                self.spawnBananaTree(plantingAreaPosition: plantingArea.position)
                
                // Add a Haptic Effect
                self.gameLogic.scoreIncreaseByOne(points: 1)
                self.timerModel.modifyTimer(by: self.gameConstants.bananaTreeRewardSeconds)
                softHaptic()
                
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
            if let spriteNode = plantingArea as? SKSpriteNode {
                let newTexture = SKTexture(imageNamed: "planting spot")
                spriteNode.texture = newTexture
            }
            
            shouldRunAction = false
            plantingArea.removeAllChildren()
        }
    }
    
    func spawnBananaTree(plantingAreaPosition: CGPoint){
        let palmTree = SKSpriteNode(imageNamed: "Palm Tree")
        palmTree.setScale(0.8)
        palmTree.zPosition = player.zPosition - 1
        palmTree.position = CGPoint(x: plantingAreaPosition.x, y: plantingAreaPosition.y+palmTree.size.width/2)
        addChild(palmTree)
    }
    
    private func isOverlappingWithPreviousCraters(position: CGPoint) -> Bool {
        let minimumDistance: CGFloat = (crater.size.width/2 + plantingArea.size.width/2 + 25)
        
        for previousPosition in previousCraterPositions {
            let distanceX = abs(position.x - previousPosition.x)
            let distanceY = abs(position.y - previousPosition.y)
            
            // Check for overlap in both x and y axes
            if distanceX < minimumDistance && distanceY < minimumDistance {
                return true // Overlapping with a previous crater
            }
        }
        
        return false
    }
    
    private func isAreaFarAway(position: CGPoint) -> Bool {
        let minimumDistance: CGFloat = gameConstants.minDistanceBetweenPlantingAreas // min distance between 2 planting areas
        
        for previousPosition in previousPlantingAreaPositions {
            let distanceY = abs(position.y - previousPosition.y)
            
            // Check for overlap in y axes
            if distanceY < minimumDistance {
                return true // Overlapping with a previous planting area
            }
        }
        return false
    }
    
    func startPlantingAreaCycle() {
        previousPlantingAreaPositions = []
        
        let createPlantingAreaAction = SKAction.run { [weak self] in
            self!.createPlantingArea()
        }
        
        let waitAction = SKAction.wait(forDuration: gameConstants.cratersGenerationIntervalInSeconds/2)
        let createAndWaitAction = SKAction.sequence([createPlantingAreaAction, waitAction])
        
        let plantingAreaAction = SKAction.repeatForever(createAndWaitAction)
        run(plantingAreaAction)
    }
    
    private func randomPlantingAreaPosition() -> CGPoint {
        let initialX: CGFloat = plantingArea.size.width/2 + 50
        let finalX: CGFloat = self.frame.width - plantingArea.size.width/2 - 50
        
        let positionX = CGFloat.random(in: initialX...finalX)
        let positionY = cam.position.y + frame.height/2 + plantingArea.size.width/2
        
        return CGPoint(x: positionX, y: positionY)
    }
}
