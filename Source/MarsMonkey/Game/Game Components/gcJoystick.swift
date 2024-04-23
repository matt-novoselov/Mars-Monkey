//
//  gcJoystick.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 12/12/23.
//

import SpriteKit

// Joysticks logic
extension GameScene{
    
    // Function to setup joystick
    func setUpJoystick() {
        // Keep joystick on the top of the game
        🕹️.zPosition = 99
        🕹️.child.zPosition = 100
        
        // Position joystick to the bottom part of the screen
        🕹️.position = CGPoint(x: 0, y: -self.frame.height/3) // Set position of the joystick
        🕹️.child.position = 🕹️.position 
        
        // Add joystick to the scene
        cam.addChild(🕹️)
        cam.addChild(🕹️.child)
    }
    
    //Update players position based on the joystick's movement
    func joystickUpdate() {
        if 🕹️.isActive {
            player.position = CGPoint(x: player.position.x - (joystickPosX * gameConstants.playerSpeed * GameLogic.shared.playerSpeedIncrementFactor),
                                      y: player.position.y + (joystickPosY * gameConstants.playerSpeed * GameLogic.shared.playerSpeedIncrementFactor))
        }
    }
    
    // Joystick becomes active after user touches the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !🕹️.isActive {
            🕹️.isActive = true
        }
    }
    
    // Function to calculate joystick position on touch
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: cam)
            
            if 🕹️.isActive {
                // All mathematical logic is performed in the "getDist" function
                let dist = 🕹️.getDist(withLocation: location)
                
                //Divide the speed by 32 to decrease the speed
                joystickPosX = dist.xDist / 32
                joystickPosY = dist.yDist / 32
            }
        }
    }
    
    // Joystick becomes inactive after user untouched the screen
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if 🕹️.isActive {
            //When the touch ends the central button of the joystick returns to the initial position
            🕹️.coreReturn()
            joystickPosX = 0
            joystickPosY = 0
        }
    }
}
