//
//  gcProgressBar.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 14/12/23.
//

import SpriteKit

extension GameScene{
    // Function to update the circle path based on the trim factor
    func updateCirclePath() {
        // Create a circle path
        let circlePath = CGMutablePath()
        let startAngle = CGFloat(2 * Double.pi * (1 - trimFactor))
        circlePath.addArc(center: CGPoint.zero, radius: 350, startAngle: startAngle, endAngle: CGFloat.pi * 2, clockwise: false)

        // Set the path for the circle node
        circleNode.path = circlePath
    }

    
    // Function to animate the trim factor from 0 to 1
    func animateTrimFactor() {
        let duration = 3.0
        let trimAction = SKAction.customAction(withDuration: duration) { (node, elapsedTime) in
            let progress = elapsedTime / CGFloat(duration)
            self.trimFactor = progress
        }

        circleNode.run(trimAction)
    }
    
    func setUpProgressBar() {
        circleNode.zRotation = CGFloat(90) * CGFloat.pi / 180.0

        // Set the stroke color
        circleNode.strokeColor = .greenTree

        // Set the stroke width
        circleNode.lineWidth = 60
        
        // Set rounded edges for the stroke
        circleNode.lineCap = .round

        // Update the circle path based on the initial trim factor
        updateCirclePath()
    }
}
