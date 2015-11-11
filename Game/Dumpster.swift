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
        self.yPos = 180
        self.zPosition = 6
    }
    
    override func initPhysics() {
        let frontCollider = SKPhysicsBody(rectangleOfSize: CGSizeMake(5, 50), center: CGPointMake(-(self.size.width / 2), 0))
        
        frontCollider.categoryBitMask = GameManager.sharedInstance.COLLIDER_OBSTACLE
        frontCollider.contactTestBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
        
        self.physicsBody = frontCollider
        
        super.initPhysics()
    }
}
