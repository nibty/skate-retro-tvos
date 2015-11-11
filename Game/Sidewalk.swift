//
//  Sidewalk.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class Sidewalk: Ground {
    convenience init() {
        self.init(imageNamed: "sidewalk")
        create()
    }
    
    func create() {
        self.zPosition = 4
        self.yPos = 185
    }
}