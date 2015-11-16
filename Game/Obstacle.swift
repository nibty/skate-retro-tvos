//
//  Obstacle.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import Foundation
import SpriteKit

class Obstacle: Movable {
    
    var passedByPlayer = false
    
    override func startMoving() {
        super.startMoving()
        self.initPhysics()
        
        self.zPosition = 8
    }
    
    func initPhysics() {
        self.physicsBody?.dynamic = false
    }
    
    override func didExceedBounds() {
        self.removeFromParent()
    }
    
    override func update() {
        super.update()
        
        if self.position.x <= GameManager.sharedInstance.CHAR_X_POSITION && passedByPlayer == false {
            GameManager.sharedInstance.score++
            passedByPlayer = true
        }
    }
}

