//
//  gcCraters.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 12.12.2023.
//

import SpriteKit
import SwiftUI

public var previousCraterPositions: [CGPoint] = []

extension GameScene{

    func createCraters() {
        
        // Randomly decide how many craters to create in a row
        let randomNumber = Int.random(in: 1...100)
        let numberOfCraters = randomNumber <= gameConstants.cratersGenerationChance ? gameConstants.maxNumberOfCratersInARow : 1
        
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
        let minimumDistance: CGFloat = (self.player.size.width + crater.size.width + 50)

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
        let initialX: CGFloat = crater.size.width/2
        let finalX: CGFloat = self.frame.width - crater.size.width/2
        
        let positionX = CGFloat.random(in: initialX...finalX)
        let positionY = cam.position.y + frame.height/2 + crater.size.width/2
        
        let randomYshift = CGFloat.random(min: -75, max: 75)
        
        return CGPoint(x: positionX, y: positionY + randomYshift + 75)
    }

    func newCrater(at position: CGPoint) {
        crater.setScale(0.6)
        let isFlipped = Bool.random() ? 1 : -1
        
        let newCrater = SKSpriteNode(imageNamed: "crater")
        newCrater.name = "crater"
        newCrater.scale(to: crater.size)
        newCrater.xScale = CGFloat(isFlipped) * crater.xScale
        newCrater.zPosition = player.zPosition - 2
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
        previousCraterPositions = []
        
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
        
        // When Crater Contacts With a Player
        if crater.name == "crater" {
            
            // Delete the Crater from the Scene
//            crater.removeFromParent()
            
            // Show pop-up text
            showPopupText(text: "\(gameConstants.decrementSecondsNumber) s", at: crater.position, nodeName: crater.name!)
            
            // Add a Haptic Effect
            heavyHaptic()
            
            // Decrement timer
            timerModel.modifyTimer(by: gameConstants.decrementSecondsNumber)
        }
    }
    
}

extension CGFloat {
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(max - min + 1))) + min
    }
}
