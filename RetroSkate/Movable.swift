//
//  Movable.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class Movable: SKSpriteNode {
    
    var resetPosition:CGFloat = -900
    var startPosition:CGFloat = 1800
    var movingSpeed = GameManager.sharedInstance.movingSpeed
    var moveAction: SKAction!
    var moveForeverAction: SKAction!
    var yPos:CGFloat = 0
    
    func startMoving() {
        self.position = CGPointMake(startPosition, yPos)
        
        moveAction = SKAction.moveByX(movingSpeed, y: 0, duration: 0.02)
        moveForeverAction = SKAction.repeatActionForever(moveAction)
        self.runAction(moveForeverAction)
    }
    
    override func update() {
        if self.position.x <= self.resetPosition {
           didExceedBounds()
        }
    }
    
    func didExceedBounds() {
        self.position = CGPointMake(self.startPosition, self.position.y)
        
        GameManager.sharedInstance.levelLoop++
    }
}