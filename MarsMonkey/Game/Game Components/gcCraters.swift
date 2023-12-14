//
//  gcCraters.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 12.12.2023.
//

import SpriteKit

private var previousCraterPositions: [CGPoint] = []

extension GameScene{

    func createCraters() {
        
        // Randomly decide how many craters to create in a row
        let numberOfCraters = Int.random(in: 1...GameConstants().maxNumberOfCratersInARow)
        var amountOfTries: Int = 0
        let maxAmountOfTries: Int = 10
        
        // Create a random number of craters
        
        for _ in 0..<numberOfCraters {
            var craterPosition: CGPoint
            repeat {
                craterPosition = self.randomCraterPosition()
                amountOfTries+=1
            } while isOverlappingWithPreviousCraters(position: craterPosition) && amountOfTries<maxAmountOfTries
            
            if amountOfTries<maxAmountOfTries{
                previousCraterPositions.append(craterPosition)
                newCrater(at: craterPosition)
            }
        }
        
    }
    
    private func isOverlappingWithPreviousCraters(position: CGPoint) -> Bool {
        let minimumDistance: CGFloat = (self.player.size.width + 340 + 50)

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
    
    private func randomCraterPosition() -> CGPoint {
        let initialX: CGFloat = 170
        let finalX: CGFloat = self.frame.width - 170
        
        let positionX = CGFloat.random(in: initialX...finalX)
        let positionY = cam.position.y + frame.height/2 + 170
        
        return CGPoint(x: positionX, y: positionY)
    }
    
    private func newCrater(at position: CGPoint) {
        let newCrater = SKSpriteNode(imageNamed: "crater")
        newCrater.name = "crater"
        newCrater.setScale(0.6)
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
    
    func startCratersCycle() {
        let createCratersAction = SKAction.run { [weak self] in
            self?.createCraters()
        }
        
        let waitAction = SKAction.wait(forDuration: GameConstants().cratersGenerationIntervalInSeconds)
        let createAndWaitAction = SKAction.sequence([createCratersAction, waitAction])
        
        
        let craterCycleAction = SKAction.repeatForever(createAndWaitAction)
        
        run(craterCycleAction)
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
            
            // Decrement timer
            timerModel.modifyTimer(by: gameConstants.decrementSecondsNumber)
        }
    }
}
