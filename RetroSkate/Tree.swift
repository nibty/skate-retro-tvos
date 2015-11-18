//
//  Tree.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class Tree: Movable {
    convenience init() {
        self.init(imageNamed: "tree\(arc4random_uniform(2))")
        self.anchorPoint = CGPointMake(0.5, 0)
        self.yPos = 200
        self.zPosition = 6
    }
    
    override func didExceedBounds() {
        self.removeFromParent()
    }
}
