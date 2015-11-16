//
//  Ledge.swift
//  Game
//
//  Created by Nicholas Pettas on 11/14/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class Ledge: Obstacle {
    
    convenience init() {
        self.init(imageNamed: "ledge")
        self.yPos = 150
        
        let topCollider = TopCollider(size: self.size)
        topCollider.position.y = topCollider.position.y - 15
        self.addChild(topCollider)
    }
    
    override func initPhysics() {
        let frontCollider = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width - 10, self.size.height - 10),  center: CGPointMake(0, -15))
        
        frontCollider.categoryBitMask = GameManager.sharedInstance.COLLIDER_OBSTACLE
        frontCollider.contactTestBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
        
        self.physicsBody = frontCollider
        
        super.initPhysics()
    }
}
