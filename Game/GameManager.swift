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
    
    let COLLIDER_OBSTACLE: UInt32 = 1 << 0
    let COLLIDER_PLAYER: UInt32 = 1 << 1
    let COLLIDER_RIDEABLE: UInt32 = 1 << 2
    let SCORE_X_ADJUSTMENT_POS_LANDSCAPE:CGFloat = -40
    let SCORE_Y_ADJUSTMENT_POS_LANDSCAPE:CGFloat = 0
    let SCORE_X_ADJUSTMENT_POS_PORTRAIT:CGFloat = -40
    let SCORE_Y_ADJUSTMENT_POS_PORTRAIT:CGFloat = -70
    let SCORE_X_ADJUSTMENT_POS_APPLETV:CGFloat = -10
    let SCORE_Y_ADJUSTMENT_POS_APPLETV:CGFloat = -70
    
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