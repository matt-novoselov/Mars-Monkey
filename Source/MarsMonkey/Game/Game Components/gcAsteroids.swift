//
//  gcAsteroids.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 12/12/23.
//

import SpriteKit

// Asteroids game logic
extension GameScene{
    
    // Function that creates and spawns an asteroid at a random position
    private func createAsteroid() {
        let asteroidPosition = self.randomAsteroidPosition()
        newAsteroid(at: asteroidPosition)
    }
    
    // Function that generates a random position for an asteroid
    private func randomAsteroidPosition() -> CGPoint {
        let initialX: CGFloat = 100
        let finalX: CGFloat = self.frame.width - 100
        
        let positionX = CGFloat.random(in: initialX...finalX)
        let positionY = cam.position.y + frame.height
        
        return CGPoint(x: positionX, y: positionY)
    }
    
    // Function to generate a random duration between min and max time interval
    func randomDuration(min: TimeInterval, max: TimeInterval) -> TimeInterval {
        return TimeInterval.random(in: min...max)
    }
    
    // Function to define a new asteroid
    private func newAsteroid(at position: CGPoint) {
        // Define asteroid texture
        let newAsteroid = SKSpriteNode(imageNamed: "asteroid")
        
        // Initiate trail smoke particle effect
        let trailSmoke: SKEmitterNode = SKEmitterNode(fileNamed: "AsteroidSmoke.sks")!
        trailSmoke.setScale(CGFloat(15))
        trailSmoke.zPosition = newAsteroid.zPosition - 1
        newAsteroid.addChild(trailSmoke)
        
        // Initiate fire particle effect
        let fire: SKEmitterNode = SKEmitterNode(fileNamed: "AsteroidFire.sks")!
        fire.setScale(CGFloat(13))
        fire.zPosition = newAsteroid.zPosition - 1
        newAsteroid.addChild(fire)

        // Set name and position for the new asteroid
        newAsteroid.name = "asteroid"
        newAsteroid.setScale(0.25)
        newAsteroid.zPosition = 🕹️.zPosition-1
        newAsteroid.position = position
        
        // Setup physics properties of the object
        newAsteroid.physicsBody = SKPhysicsBody(circleOfRadius: newAsteroid.size.width/2)
        newAsteroid.physicsBody?.affectedByGravity = true
        
        newAsteroid.physicsBody?.categoryBitMask = InstanceCategory.asteroid
        newAsteroid.physicsBody?.contactTestBitMask = InstanceCategory.player
        newAsteroid.physicsBody?.collisionBitMask = 0
        newAsteroid.physicsBody?.isDynamic = true
        
        // Spawn new asteroid
        addChild(newAsteroid)
        
        newAsteroid.run(
            SKAction.wait(forDuration: randomDuration(min: 3.0, max: 10.0))
        )
    }
    
    // Asteroids Cycle
    func startAsteroidsCycle() {
        let createAsteroidAction = SKAction.run(createAsteroid)
        let waitAction = SKAction.wait(forDuration: 5.0)
        
        let createAndWaitAction = SKAction.sequence([createAsteroidAction, waitAction])
        let asteroidCycleAction = SKAction.repeatForever(createAndWaitAction)
        
        run(asteroidCycleAction)
    }
    
}

// Registering the Contact of an Asteroid with a Player
extension GameScene {
    
    func handleAsteroidContact(asteroid: SKNode) {
        
        // When Asteroid Contacts With a Player
        if asteroid.name == "asteroid" {
            
            // Delete the Asteroid from the Scene
            asteroid.removeFromParent()
            
            playOneShotSound(filename: "asteroid")
            
            // Show pop-up text
            showPopupText(text: "\(gameConstants.decrementSecondsNumber) s", at: asteroid.position, nodeName: asteroid.name!)
            
            // Add a Haptic Effect
            sequenceHeavyHaptic()
            
            // Decrement timer
            timerModel.modifyTimer(by: gameConstants.decrementSecondsNumber)
        }
    }
}
