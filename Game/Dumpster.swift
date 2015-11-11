//
//  Dumpster.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class Dumpster: Obstacle {
    convenience init() {
        self.init(imageNamed: "dumpster")
    }
    
    override func initPhysics() {
        let frontCollider = SKPhysicsBody(rectangleOfSize: CGSizeMake(5, self.size.height), center: CGPointMake(-(self.size.width / 2), 0))
        let topCollider = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width * 0.80, 5), center: CGPointMake(0, self.size.height / 2 - 7))
        
        self.physicsBody = SKPhysicsBody(bodies: [frontCollider, topCollider])
        
        super.initPhysics()
    }
}
