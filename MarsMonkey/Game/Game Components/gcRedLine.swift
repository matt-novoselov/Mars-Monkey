//
//  gcRedLine.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 12/12/23.
//

import SpriteKit

extension GameScene{
    func setUpRedLine() {
        redLine.anchorPoint = CGPointZero
        redLine.zPosition = 98
        self.addChild(redLine)
    }
    
    func redLineUpdate() {
        redLine.position = CGPoint(x: 0, y: cam.position.y - scene!.frame.width - 100)
    }
}
