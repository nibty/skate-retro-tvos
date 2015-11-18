//
//  FireHydrant.swift
//  Game
//
//  Created by Nicholas Pettas on 11/14/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class FireHydrant: Movable {
    convenience init() {
        self.init(imageNamed: "fire_hydrant")
        self.anchorPoint = CGPointMake(0.5, 0)
        self.yPos = 165
        self.zPosition = 7
    }
    
    override func didExceedBounds() {
        self.removeFromParent()
    }
}
