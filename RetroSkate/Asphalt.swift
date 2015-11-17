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
        yPos = GameManager.sharedInstance.ASPHALT_Y_POSTION
    }
}