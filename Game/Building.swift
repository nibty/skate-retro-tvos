//
//  Building.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class Building: Movable {
    convenience init() {
        self.init(imageNamed: "building\(arc4random_uniform(8))")
        self.anchorPoint = CGPointMake(0.5, 0) // need to ancher on the bottom of the building
        self.yPos = 200
        self.zPosition = 5
    }
    
    override func didExceedBounds() {
        super.didExceedBounds()
        
    self.texture = SKTexture(imageNamed: "building\(arc4random_uniform(8))")
    }
}
