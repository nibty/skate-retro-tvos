//
//  Obstacle.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import Foundation
import SpriteKit

class Obstacle: SKSpriteNode {
    
    static let RESET_X_POS: CGFloat = -800
    static let START_X_POS: CGFloat = 1800

    var moveAction: SKAction!
    var moveForeverAction: SKAction!
    
    
    func startMoving() {
        self.position = CGPointMake(Obstacle.START_X_POS, 185)
        
        moveAction = SKAction.moveByX(GameManager.sharedInstance.MOVEMENT_SPEED, y: 0, duration: 0.02)
        moveForeverAction = SKAction.repeatActionForever(moveAction)
        
        self.zPosition = 7
        self.runAction(moveForeverAction)
        
        self.initPhysics()
    }
    
    override func update() {
        if self.position.x <= Obstacle.RESET_X_POS {
            self.position = CGPointMake(Obstacle.START_X_POS, self.position.y)
        }
    }
    
    func initPhysics() {
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = GameManager.sharedInstance.COLLIDER_OBSTACLE
        self.physicsBody?.contactTestBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
    }
    
}

