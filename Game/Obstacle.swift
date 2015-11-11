//
//  Obstacle.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import Foundation
import SpriteKit

class Obstacle: Movable {
    override func startMoving() {
        super.startMoving()
        self.initPhysics()
    }
    
    func initPhysics() {
        self.physicsBody?.dynamic = false

    }
}

