//
//  Rail.swift
//  Game
//
//  Created by Nicholas Pettas on 11/14/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class Rail: Obstacle {
    
    convenience init() {
        self.init(imageNamed: "rail")
        self.yPos = 150
        
        let topCollider = TopCollider(size: self.size)
        self.addChild(topCollider)
    }
    
    override func initPhysics() {
        let frontCollider = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width - 5, self.size.height),  center: CGPointMake(0, -5))
        
        frontCollider.categoryBitMask = GameManager.sharedInstance.COLLIDER_OBSTACLE
        frontCollider.contactTestBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
        
        self.physicsBody = frontCollider
    
        super.initPhysics()
    }
}
