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
    
    // Colliders
    let COLLIDER_OBSTACLE: UInt32 = 1 << 0
    let COLLIDER_PLAYER: UInt32 = 1 << 1
    let COLLIDER_RIDEABLE: UInt32 = 1 << 2
    
    // Score label position
    let SCORE_X_ADJUSTMENT_POS_LANDSCAPE:CGFloat = -40
    let SCORE_Y_ADJUSTMENT_POS_LANDSCAPE:CGFloat = 0
    let SCORE_X_ADJUSTMENT_POS_PORTRAIT:CGFloat = -40
    let SCORE_Y_ADJUSTMENT_POS_PORTRAIT:CGFloat = -70
    let SCORE_X_ADJUSTMENT_POS_APPLETV:CGFloat = -10
    let SCORE_Y_ADJUSTMENT_POS_APPLETV:CGFloat = -70
    
    // Ground setup
    let ASP_PIECES = 25
    let SIDEWALK_PIECES = 35
    let GROUND_X_RESET: CGFloat = -200
    let ASPHALT_Y_POSTION: CGFloat = 140
    let SIDEWALK_Y_POSTION: CGFloat = 185
    let SIDEWALK_Z_POSTION: CGFloat = 4
    let FLOOR_WIDTH: CGFloat = 1200
    let FLOOR_HEIGHT: CGFloat = 5
    let FLOOR_POSITION_X: CGFloat = 540
    let FLOOR_POSITION_Y: CGFloat = 125
    
    // Movables setup
    var dumpsterXStartPosition:CGFloat = 0
    var isJumping = false
    var movingSpeed:CGFloat = -8.5
    
    // Sound effects
    var jumpSoundAction = SKAction.playSoundFileNamed("sfxOllie.wav", waitForCompletion: false)
    var gameOverSoundAction = SKAction.playSoundFileNamed("sfxGameOver.wav", waitForCompletion: false)
    
    var gameOver = false
    
    var score = 0
    
    func incrementScore() {
        score++
    }
}