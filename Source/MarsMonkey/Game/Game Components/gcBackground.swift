//
//  gcBackground.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 12/12/23.
//

import SpriteKit

// Background tiles game logic
extension GameScene{
    
    // Setup the background tiles
    func setUpBackground() {
        // Setup first tile
        background.anchorPoint = CGPointZero
        background.zPosition = -15
        self.addChild(background)
        
        // Setup second tile
        background2.anchorPoint = CGPointZero
        background2.zPosition = -15
        self.addChild(background2)
    }
    
    // Update background tiles movement
    // There are 2 tiles in the scene that jump over each other that creates an illusion of the infinite canvas
    func backgroundUpdate() {
        // Determine how many times background tiles should have already been displayed
        amountOfCycles = Int(cam.position.y) / Int(background2.size.height)
        background.position = CGPointMake(0, background2.size.height * CGFloat(amountOfCycles) - background.size.height/2)
        background2.position = CGPointMake(0, background2.size.height * CGFloat(amountOfCycles+1) - background2.size.height/2)
    }
}
