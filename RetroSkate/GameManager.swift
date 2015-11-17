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
    let SCORE_X_ADJUSTMENT_POS_LANDSCAPE:CGFloat = -20
    let SCORE_Y_ADJUSTMENT_POS_LANDSCAPE:CGFloat = 30
    let SCORE_X_ADJUSTMENT_POS_PORTRAIT:CGFloat = -40
    let SCORE_Y_ADJUSTMENT_POS_PORTRAIT:CGFloat = -70
    let SCORE_POSITION_X_APPLETV:CGFloat = 1120
    let SCORE_POSITION_Y_APPLETV:CGFloat = 700
    
    // Player setup
    let CHAR_X_POSITION: CGFloat = 158
    let CHAR_Y_POSITION: CGFloat = 175
    let PLAYER_Z_POSITION: CGFloat = 10

    // World setup
    let GRAVITY_Y: CGFloat = -10
    
    // Background setup
    let BACKGROUND_COLOR = UIColor(red: 73/255.0, green: 148/255.0, blue: 204/255.0, alpha: 1)

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
    var movingSpeed:CGFloat = -8.5
    
    // Misc
    let IPHONE_PLUS_WIDTH: CGFloat = 414
    
    var levelLoop = 0
    var gameOver = false
    var score = 0
    let TOP_SCORE_STORAGE_KEY = "highscore"

}