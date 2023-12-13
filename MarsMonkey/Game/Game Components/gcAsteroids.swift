//
//  gcAsteroids.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 12/12/23.
//

import SpriteKit

extension GameScene{
    private func createAsteroid() {
        let asteroidPosition = self.randomAsteroidPosition()
        newAsteroid(at: asteroidPosition)
    }
    
    private func randomAsteroidPosition() -> CGPoint {
        let initialX: CGFloat = 100
        let finalX: CGFloat = self.frame.width - 100
        
        let positionX = CGFloat.random(in: initialX...finalX)
        let positionY = cam.position.y + frame.height
        
        return CGPoint(x: positionX, y: positionY)
    }
    
    // Function to generate a random duration between min and max
    func randomDuration(min: TimeInterval, max: TimeInterval) -> TimeInterval {
        return TimeInterval.random(in: min...max)
    }
    
    private func newAsteroid(at position: CGPoint) {
        let newAsteroid = SKSpriteNode(imageNamed: "asteroid")
        newAsteroid.name = "asteroid"
        newAsteroid.setScale(0.25)
        newAsteroid.zPosition = player.zPosition
        newAsteroid.position = position
        
        newAsteroid.physicsBody = SKPhysicsBody(circleOfRadius: newAsteroid.size.width/2)
        newAsteroid.physicsBody?.affectedByGravity = true
        
        newAsteroid.physicsBody?.categoryBitMask = InstanceCategory.asteroid
        newAsteroid.physicsBody?.contactTestBitMask = InstanceCategory.player
        newAsteroid.physicsBody?.collisionBitMask = InstanceCategory.player
        
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
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let asteroidNode = contact.bodyA.node?.name == "asteroid" ? contact.bodyA.node : contact.bodyB.node
        
        // When Asteroid Contacts With a Player
        if let asteroid = asteroidNode {
            // Delete the Asteroid from the Scene
            asteroid.removeFromParent()
            // Add a Haptic Effect
            heavyHaptic()
            // Decrement timer
            timerModel.decrementTimer(by: gameConstants.decrementSecondsNumber)
        }
    }
}
