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
        self.yPos = 150
        
        let topCollider = TopCollider(size: self.size)
        self.addChild(topCollider)
    }
    
    override func initPhysics() {
        let frontCollider = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width - 10, self.size.height - 10),  center: CGPointMake(0, -10))

        frontCollider.categoryBitMask = GameManager.sharedInstance.COLLIDER_OBSTACLE
        frontCollider.contactTestBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
        
        self.physicsBody = frontCollider
        
        super.initPhysics()
    }
}
