//
//  Player.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    // Character setup
    var charPushFrames = [SKTexture]()
    var charCrashFrames = [SKTexture]()
    var charOllieFrames = [SKTexture]()
    var charFlipFrames = [SKTexture]()
    

    convenience init() {
        self.init(imageNamed: "push0")
        createCharacter()
    }
    
    override func update() {
        if GameManager.sharedInstance.isJumping {
            
            if floor((self.physicsBody?.velocity.dy)!) == 0 {
                GameManager.sharedInstance.isJumping = false
                GameManager.sharedInstance.isTricking = false
            }
        }
    }
    
    func createCharacter() {
        self.zPosition = GameManager.sharedInstance.PLAYER_Z_POSITION

        for var x = 0; x < 12; x++ {
            charPushFrames.append(SKTexture(imageNamed: "push\(x)"))
        }
        
        for var x = 0; x < 9; x++ {
            charCrashFrames.append(SKTexture(imageNamed: "crash\(x)"))
        }
        
        for var x = 0; x < 10; x++ {
            charOllieFrames.append(SKTexture(imageNamed: "ollie\(x)"))
        }
        
        for var x = 0; x < 12; x++ {
            charFlipFrames.append(SKTexture(imageNamed: "flip\(x)"))
        }
        
        #if os(tvOS)
            self.position = CGPointMake(GameManager.sharedInstance.CHAR_X_POSITION, GameManager.sharedInstance.CHAR_Y_POSITION)
        #else
            // move player to the left on iphones
            self.position = CGPointMake(GameManager.sharedInstance.CHAR_X_POSITION - 100, GameManager.sharedInstance.CHAR_Y_POSITION)
        #endif

        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width - 50, self.size.height - 20))
        self.physicsBody?.restitution = 0
        self.physicsBody?.linearDamping = 0.1
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 0.1
        self.physicsBody?.dynamic = true
        self.physicsBody?.categoryBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
        self.physicsBody?.contactTestBitMask = GameManager.sharedInstance.COLLIDER_OBSTACLE
        
        playPushAnim()
    }
    
    func jump() {
        if !GameManager.sharedInstance.isJumping && !GameManager.sharedInstance.gameOver {
            GameManager.sharedInstance.isJumping = true
            
            self.physicsBody?.applyImpulse(CGVectorMake(0.0, 70.0))
            self.runAction(AudioManager.sharedInstance.jumpSoundAction)
        }
    }
    
    func ollie() {
        if GameManager.sharedInstance.isJumping && !GameManager.sharedInstance.gameOver && !GameManager.sharedInstance.isTricking {
            GameManager.sharedInstance.isTricking = true;
            playOllieAnim()
            
            self.runAction(AudioManager.sharedInstance.jumpSoundAction)
            self.physicsBody?.applyImpulse(CGVectorMake(0.0, 40))
            GameManager.sharedInstance.score++
        }
    }
    
    func flip() {
        if GameManager.sharedInstance.isJumping && !GameManager.sharedInstance.gameOver && !GameManager.sharedInstance.isTricking {
            GameManager.sharedInstance.isTricking = true;
            playFlipAnim()
            
            self.runAction(AudioManager.sharedInstance.jumpSoundAction)
            self.physicsBody?.applyImpulse(CGVectorMake(0.0, 40))
            GameManager.sharedInstance.score++
        }
    }
    
    func playFlipAnim() {
        if !GameManager.sharedInstance.gameOver {
            self.removeAllActions()
            
            self.runAction(SKAction.animateWithTextures(charFlipFrames, timePerFrame: 0.05))
            let wait = SKAction.waitForDuration(0.55)
            self.runAction(wait, completion:  {() -> Void in
                self.playPushAnim()
            })
        }
    }
    
    func playCrashAnim() {
        if !GameManager.sharedInstance.gameOver {
            self.removeAllActions()
            
            self.runAction(AudioManager.sharedInstance.gameOverSoundAction)
    
            self.runAction(SKAction.animateWithTextures(charCrashFrames, timePerFrame: 0.05))
        }
    }
    
    func playPushAnim() {
        self.removeAllActions()
        
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(charPushFrames, timePerFrame: 0.1)))
    }
    
    func playOllieAnim() {
        self.removeAllActions()

        self.runAction(SKAction.animateWithTextures(charOllieFrames, timePerFrame: 0.05))
        let wait = SKAction.waitForDuration(0.6)
        self.runAction(wait, completion:  {() -> Void in
            self.playPushAnim()
        })
    }
}