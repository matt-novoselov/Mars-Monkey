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
        addChild(🕹️)
        addChild(🕹️.child)
    }
    
    func joystickUpdate() {
        🕹️.position = CGPoint(x: scene!.frame.width/2, y: cam.position.y - scene!.frame.height/3) // Set position of the joystick
        
        if !🕹️.isActive{
            🕹️.child.position = CGPoint(x: 🕹️.position.x, y: 🕹️.position.y) // Set position of the joystick's child
        }
        
        if 🕹️.isActive { //Update players position based on the joystick's movement
            player.position = CGPoint(x: player.position.x - (joystickPosX * gameConstants.playerSpeed),
                                      y: player.position.y + (joystickPosY * gameConstants.playerSpeed))
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
            let location = touch.location(in: self)
            
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
