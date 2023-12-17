//
//  gcJoystick.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 12/12/23.
//

import SpriteKit

// Joysticks logic
extension GameScene{
    func setUpJoystick() {
        🕹️.zPosition = 99
        🕹️.child.zPosition = 100
        
        🕹️.position = CGPoint(x: 0, y: -self.frame.height/3) // Set position of the joystick
        🕹️.child.position = 🕹️.position 
        
        cam.addChild(🕹️)
        cam.addChild(🕹️.child)
    }
    
    func joystickUpdate() {
        if 🕹️.isActive { //Update players position based on the joystick's movement
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
    
    // Joystick becomes inactive after user untouches the screen
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if 🕹️.isActive {
            //When the touch ends the central button of the joystick returns to the initial position and speed
            🕹️.coreReturn()
            joystickPosX = 0
            joystickPosY = 0
        }
    }
}
