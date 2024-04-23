//
//  gcCamera.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 12/12/23.
//

import SpriteKit

// Camera logic
extension GameScene{
    
    // Setup camera
    func setUpCamera() {
        // Initial camera position equals to the player position
        cam.position = player.position
        self.camera = cam
        addChild(cam)
    }
    
    // Update camera position each frame, so it goes up
    func cameraUpdate() {
        cam.position.y += gameConstants.cameraMovementSpeed * GameLogic.shared.cameraSpeedIncrementFactor
    }
}
