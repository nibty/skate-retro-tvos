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
        self.zPosition = 7
    }
    
    override func initPhysics() {
        let frontCollider = SKPhysicsBody(rectangleOfSize: CGSizeMake(2, 70), center: CGPointMake(-(self.size.width / 2) + 5, 0))
        
        frontCollider.categoryBitMask = GameManager.sharedInstance.COLLIDER_OBSTACLE
        frontCollider.contactTestBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
        
        self.physicsBody = frontCollider
        
        super.initPhysics()
    }
    
    override func didExceedBounds() {
        var random = Utils.randomStart()
        if abs(GameManager.sharedInstance.dumpsterXStartPosition - random) < 400 {
            random += 400
        }
        GameManager.sharedInstance.dumpsterXStartPosition = random
        
        self.position = CGPointMake(random, self.position.y)
        
        passedPlayer = false
    }
    
    override func update() {
        super.update()
        
        if self.position.x <= 158 && passedPlayer == false {
            GameManager.sharedInstance.incrementScore()
            passedPlayer = true
        }
    }
}
