//
//  GameManager.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit


class GameManager {
    static let sharedInstance = GameManager()
    
    let MOVEMENT_SPEED: CGFloat = -8.5
    
    // colliders
    let COLLIDER_OBSTACLE: UInt32 = 1 << 0
    let COLLIDER_PLAYER: UInt32 = 1 << 1

}