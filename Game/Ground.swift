//
//  Ground.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class Ground: SKSpriteNode {
    var moveGroundAction = SKAction!()
    var moveGroundActionForever = SKAction!()
    var yPos: CGFloat!
    
    func startMoving() {
        moveGroundAction = SKAction.moveByX(GameManager.sharedInstance.MOVEMENT_SPEED, y: 0, duration:  0.02)
        moveGroundActionForever = SKAction.repeatActionForever(moveGroundAction)
        self.runAction(moveGroundActionForever)
    }
}
