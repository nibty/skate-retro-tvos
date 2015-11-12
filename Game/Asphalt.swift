//
//  Asphalt.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class Asphalt: Ground {
    convenience init() {
        self.init(imageNamed: "asphalt_med")
        create()
    }
    
    func create() {
//        let collider = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width, 5), center: CGPointMake(0, -20))
//        collider.dynamic = false
//        self.physicsBody = collider
        yPos = 140
    }
}