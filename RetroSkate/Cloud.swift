//
//  Cloud.swift
//  Game
//
//  Created by Nicholas Pettas on 11/11/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class Cloud: Movable {
    convenience init() {
        self.init(imageNamed: "cloud\(arc4random_uniform(2))")
        self.anchorPoint = CGPointMake(0.5, 0)
        self.yPos = 575
        self.zPosition = 1
        self.alpha = 0.7
    }
    
    override func didExceedBounds() {
        self.removeFromParent()
    }
}
