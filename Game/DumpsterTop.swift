//
//  DumpsterTop.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class DumbsterTop: Obstacle {
    convenience init() {
        self.init(color: UIColor.clearColor(), size: CGSizeMake(120,5))
        self.yPos = 190
        self.zPosition = 7
    }
    
    override func initPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody!.categoryBitMask = GameManager.sharedInstance.COLLIDER_RIDEABLE
        self.physicsBody!.contactTestBitMask = GameManager.sharedInstance.COLLIDER_PLAYER

        super.initPhysics()
    }
    
    override func didExceedBounds() {
        self.position = CGPointMake(GameManager.sharedInstance.dumpsterXStartPosition, self.position.y)
    }
    
}
