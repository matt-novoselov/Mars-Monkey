//
//  gcCamera.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 12/12/23.
//

import SpriteKit

extension GameScene{
    func setUpCamera() {
        cam.position = player.position
        self.camera = cam
    }
    
    func cameraUpdate() {
        cam.position.y += gameConstants.cameraMovementSpeed
    }
}
