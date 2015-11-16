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
    
    var muteAudio = false
    
    // Music
    let music = SKAudioNode(fileNamed: "musicMain.wav")
    
    // Sound effects
    let jumpSoundAction = SKAction.playSoundFileNamed("sfxOllie.wav", waitForCompletion: false)
    let gameOverSoundAction = SKAction.playSoundFileNamed("sfxGameOver.wav", waitForCompletion: false)

    func playMusic(scene: GameScene) {
        if !muteAudio {
            scene.addChild(music)
        }
    }
    
    func stopMusic() {
        music.removeFromParent()
    }
    
    func playJumpSoundEffect(node: SKNode) {
        if !muteAudio {
            node.runAction(jumpSoundAction)
        }
    }
    
    func playGameOverSoundEffect(node: SKNode) {
        if !muteAudio {
            node.runAction(gameOverSoundAction)
        }
    }
}