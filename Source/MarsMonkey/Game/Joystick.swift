//
//  Joystick.swift
//  joystick
//

import SpriteKit

class Joystick: SKShapeNode {
    
    // Indicates whether the joystick is active or not
    public var isActive: Bool = false
    
    // Radius of the joystick
    private(set) var radius: CGFloat = 0
    
    // Child node representing the joystick's button
    private(set) var child: SKShapeNode = SKShapeNode()
    
    // Vector representing the direction of the joystick
    private(set) var vector: CGVector = CGVector()
    
    // Angle of the joystick
    private(set) var angle: CGFloat = 0
    
    // Radius of the joystick's base
    private(set) var raio: CGFloat = 0
    
    // Constant representing 90 degrees in radians
    private var radius90: CGFloat = 1.57079633
    
    // MARK: Initialization
    override init() {
        super.init()
    }

    // Convenience initializer with a specified radius
    convenience init(radius: CGFloat) {
        self.init()
        self.radius = radius
        createJoystickBase()
        createJoystickBaseMain()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Set up properties of the joystick's base
    private func createJoystickBase() {
        self.path = CGPath(ellipseIn: CGRect(origin: CGPoint(x: -radius, y: -radius),
                                             size: CGSize(width: radius * 2, height: radius * 2)),
                           transform: nil)
        self.strokeColor = .black
        self.alpha = 0.7
        self.lineWidth = 15
        self.zPosition = 99
    }
    
    // Set up properties of the joystick's button
    private func createJoystickBaseMain() {
        child = SKShapeNode(circleOfRadius: radius / 2)
        child.fillColor = .mmPink
        child.strokeColor = .black
        child.alpha = 1
        child.lineWidth = 5
        child.zPosition = 100
    }

    // Perform mathematical calculations based on the joystick's position
    public func getDist(withLocation location: CGPoint) -> (xDist: CGFloat, yDist: CGFloat) {
        
        vector = CGVector(dx: location.x - self.position.x,
                          dy: location.y - self.position.y)
        angle = atan2(vector.dy, vector.dx)
        raio = self.frame.size.height / 2.0
        
        let xDist: CGFloat = sin(angle - radius90) * raio
        let yDist: CGFloat = cos(angle - radius90) * raio
        
        if (self.frame.contains(location)) {
            self.child.position = location
        } else {
            self.child.position = CGPoint(x: self.position.x - xDist,
                                          y: self.position.y + yDist)
        }
        
        return (xDist: xDist, yDist: yDist)
    }
    
    // Return the joystick's button to the center after it's untouched
    public func coreReturn() {
        let retorno: SKAction = SKAction.move(to: self.position, duration: 0.05)
        retorno.timingMode = .easeOut
        child.run(retorno)
        isActive = false
    }
}

