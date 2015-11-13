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
        self.zPosition = GameManager.sharedInstance.SIDEWALK_Z_POSTION
        self.yPos = GameManager.sharedInstance.SIDEWALK_Y_POSTION
    }
}