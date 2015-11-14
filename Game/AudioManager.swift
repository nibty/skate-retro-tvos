//
//  AudioManager.swift
//  Game
//
//  Created by Nicholas Pettas on 11/13/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class AudioManager {
    
    static let sharedInstance = AudioManager()

    // Sound effects
    let jumpSoundAction = SKAction.playSoundFileNamed("sfxOllie.wav", waitForCompletion: false)
    let gameOverSoundAction = SKAction.playSoundFileNamed("sfxGameOver.wav", waitForCompletion: false)
    
    // Music
    let backgroundMusic = SKAudioNode(fileNamed: "musicMain.wav")
}