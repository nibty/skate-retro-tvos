//
//  Movable.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class Movable: SKSpriteNode {
    
    static let RESET_X_POS: CGFloat = -800
    var startPosition:CGFloat = 1800
    
    var moveAction: SKAction!
    var moveForeverAction: SKAction!
    var yPos:CGFloat = 0
    
    func startMoving() {
        self.position = CGPointMake(startPosition, yPos)
        
        moveAction = SKAction.moveByX(GameManager.sharedInstance.MOVEMENT_SPEED, y: 0, duration: 0.02)
        moveForeverAction = SKAction.repeatActionForever(moveAction)
        
        self.runAction(moveForeverAction)
    }
    
    override func update() {
        if self.position.x <= Movable.RESET_X_POS {
           didExceedBounds()
        }
    }
    
    func didExceedBounds() {
        self.position = CGPointMake(self.startPosition, self.position.y)
    }
}
