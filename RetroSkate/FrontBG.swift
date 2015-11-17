//
//  FrontBG.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class FrontBG: Background {
    convenience init() {
        self.init(imageNamed: "bg1")
        create()
    }
    
    func create() {
        self.zPosition = 3
        self.yPos = 400
        action = SKAction.repeatActionForever(SKAction.moveByX(-2.0, y: 0, duration: 0.02))
        self.runAction(action)
    }
}