//
//  FarBG.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class FarBG: Background {   
    convenience init() {
        self.init(imageNamed: "bg3")
        create()
    }
    
    func create() {
        self.zPosition = 1
        self.yPos = 450
        action = SKAction.repeatActionForever(SKAction.moveByX(-0.5, y: 0, duration: 0.02))
        self.runAction(action)
    }
}