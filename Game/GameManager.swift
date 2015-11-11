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
    let COLLIDER_RIDEABLE: UInt32 = 1 << 2

    var gameOver = false
    
    var dumpsterXStartPosition:CGFloat = 0
    var isJumping = false
    var movingSpeed:CGFloat = -8.5
    
    var score = 0
    
    func incrementScore() {
        score++
    }
    
    var jumpSoundAction = SKAction.playSoundFileNamed("sfxOllie.wav", waitForCompletion: false)
    var gameOverSoundAction = SKAction.playSoundFileNamed("sfxGameOver.wav", waitForCompletion: false)

}