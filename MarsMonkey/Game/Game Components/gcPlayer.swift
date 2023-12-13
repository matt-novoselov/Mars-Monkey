//
//  gcPlayer.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 12/12/23.
//

import SpriteKit

extension GameScene{
    func setUpPlayer() {
        player.position = CGPoint(x: size.width/2, y: size.height/2)
        player.zPosition = 10
        player.setScale(0.05)
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height))
        player.physicsBody?.affectedByGravity = false
        // Setting CollisionBitMask, CategoryBitMask and ContactBitMask for a Player
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.categoryBitMask = InstanceCategory.player
        player.physicsBody?.contactTestBitMask = InstanceCategory.asteroid
        player.physicsBody?.isDynamic = true
        addChild(player)
    }
    
    func playerUpdate() {
        let xRange = SKRange(lowerLimit: 35, upperLimit: frame.width - 35)
        let xConstraint = SKConstraint.positionX(xRange)
        let yRange = SKRange(lowerLimit: cam.position.y - scene!.frame.height/2 + 50, upperLimit: cam.position.y + scene!.frame.height/2 - 50)
        let yConstraint = SKConstraint.positionY(yRange)
        self.player.constraints = [xConstraint, yConstraint] // Limit player's movement on X and Y axis
    }
}
