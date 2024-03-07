//
//  gcBackground.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 12/12/23.
//

import SpriteKit

extension GameScene{
    func setUpBackground() {
        background.anchorPoint = CGPointZero
        background.zPosition = -15
        self.addChild(background)
        background2.anchorPoint = CGPointZero
        background2.zPosition = -15
        self.addChild(background2)
    }
    
    func backgroundUpdate() {
        amountOfCycles = Int(cam.position.y) / Int(background2.size.height)
        background.position = CGPointMake(0, background2.size.height * CGFloat(amountOfCycles) - background.size.height/2)
        background2.position = CGPointMake(0, background2.size.height * CGFloat(amountOfCycles+1) - background2.size.height/2)
    }
}
