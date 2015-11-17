//
//  DumpsterTop.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class TopCollider: SKSpriteNode {
    convenience init(size: CGSize) {
        self.init(color: UIColor.clearColor(), size: CGSizeMake(size.width - 5, 5))
        self.zPosition = 2
        
        initPhysics(size)
    }
    
    func initPhysics(size: CGSize) {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody!.categoryBitMask = GameManager.sharedInstance.COLLIDER_RIDEABLE
        self.physicsBody!.contactTestBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
        self.physicsBody!.dynamic = false

        self.position = CGPointMake(0, size.height / 2)
    }
}
