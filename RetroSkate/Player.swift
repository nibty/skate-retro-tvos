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
    
    var isJumping = false
    var isOllieTrick = false
    var isFlipTrick = false
    
    convenience init() {
        self.init(imageNamed: "push0")
        createCharacter()
    }
    
    override func update() {
        if isJumping {
            
            if floor((self.physicsBody?.velocity.dy)!) == 0 {
                isJumping = false
                isOllieTrick = false
                isFlipTrick = false
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
        
        self.position = CGPointMake(GameManager.sharedInstance.CHAR_X_POSITION, GameManager.sharedInstance.CHAR_Y_POSITION)

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
        if !isJumping && !GameManager.sharedInstance.gameOver {
            isJumping = true
            
            self.physicsBody?.applyImpulse(CGVectorMake(0.0, 55))
            AudioManager.sharedInstance.playJumpSoundEffect(self)
        }
    }
    
    func ollie() {
        if isJumping && !GameManager.sharedInstance.gameOver && !isOllieTrick {
            isOllieTrick = true;
            playOllieAnim()
            
            AudioManager.sharedInstance.playJumpSoundEffect(self)
            self.physicsBody?.applyImpulse(CGVectorMake(0.0, 25))
            GameManager.sharedInstance.score++
        }
    }
    
    func flip() {
        if isJumping && !GameManager.sharedInstance.gameOver && !isFlipTrick {
            isFlipTrick = true;
            playFlipAnim()
            
            AudioManager.sharedInstance.playJumpSoundEffect(self)
            self.physicsBody?.applyImpulse(CGVectorMake(0.0, 25))
            GameManager.sharedInstance.score++
        }
    }
    
    func playFlipAnim() {
        if !GameManager.sharedInstance.gameOver {
            self.removeAllActions()
            
            self.runAction(SKAction.animateWithTextures(charFlipFrames, timePerFrame: 0.05))
            let wait = SKAction.waitForDuration(0.55)
            self.runAction(wait, completion:  {() -> Void in
                self.isOllieTrick = false
                self.isFlipTrick = false
                self.playPushAnim()
            })
        }
    }
    
    func playCrashAnim() {
        if !GameManager.sharedInstance.gameOver {
            self.removeAllActions()
            
            AudioManager.sharedInstance.playGameOverSoundEffect(self)
    
            self.runAction(SKAction.animateWithTextures(charCrashFrames, timePerFrame: 0.05))
        }
    }
    
    func playPushAnim() {
        self.removeAllActions()
        
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(charPushFrames, timePerFrame: 0.1)))
    }
    
    func playOllieAnim() {
        self.removeAllActions()

        self.runAction(SKAction.animateWithTextures(charOllieFrames, timePerFrame: 0.04))
        let wait = SKAction.waitForDuration(0.48)
        self.runAction(wait, completion:  {() -> Void in
            self.isOllieTrick = false
            self.isFlipTrick = false
            self.playPushAnim()
        })
    }
}