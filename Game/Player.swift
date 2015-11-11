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
    let CHAR_X_POSITION:CGFloat = 158
    let CHAR_Y_POSITION:CGFloat = 175
    var isJumping = false
    var charCrashFrames = [SKTexture]()
    var charOllieFrames = [SKTexture]()
    
    convenience init() {
        self.init(imageNamed: "push0")
        createCharacter()
    }
    
    override func update() {
        if GameManager.sharedInstance.isJumping {
            
            if floor((self.physicsBody?.velocity.dy)!) == 0 {
                GameManager.sharedInstance.isJumping = false
            }
        }
    }
    
    func createCharacter() {
        for var x = 0; x < 12; x++ {
            charPushFrames.append(SKTexture(imageNamed: "push\(x)"))
        }
        
        for var x = 0; x < 9; x++ {
            charCrashFrames.append(SKTexture(imageNamed: "crash\(x)"))
        }
        
        for var x = 0; x < 10; x++ {
            charOllieFrames.append(SKTexture(imageNamed: "ollie\(x)"))
        }
        
        self.position = CGPointMake(CHAR_X_POSITION, CHAR_Y_POSITION)
        self.zPosition = 10
        
        playPushAnim()
        
//        let frontColliderSize = CGSizeMake(5, self.size.height * 0.80)
//        let frontCollider = SKPhysicsBody(rectangleOfSize: frontColliderSize, center: CGPointMake(25, 0))
//        
//        let bottomColliderSize = CGSizeMake(self.size.width / 2, 2)
//        let bottomCollider = SKPhysicsBody(rectangleOfSize: bottomColliderSize, center: CGPointMake(0, -(self.size.height / 2) + 5))
//        
//        self.physicsBody = SKPhysicsBody(bodies: [frontCollider, bottomCollider])

        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width - 50, self.size.height - 20))
        self.physicsBody?.restitution = 0
        self.physicsBody?.linearDamping = 0.1
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 0.1
        self.physicsBody?.dynamic = true
        
        self.physicsBody?.categoryBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
        self.physicsBody?.contactTestBitMask = GameManager.sharedInstance.COLLIDER_OBSTACLE
    }
    
    func jump() {
        if !GameManager.sharedInstance.isJumping && !GameManager.sharedInstance.gameOver {
            GameManager.sharedInstance.isJumping = true
            
            self.physicsBody?.applyImpulse(CGVectorMake(0.0, 70.0))
            self.runAction(GameManager.sharedInstance.jumpSoundAction)
        }
    }
    
    func ollie() {
        if GameManager.sharedInstance.isJumping && !GameManager.sharedInstance.gameOver {
            playOllieAnim()
            self.runAction(GameManager.sharedInstance.jumpSoundAction)
            self.physicsBody?.applyImpulse(CGVectorMake(0.0, 30))
        }
    }
    
    func playCrashAnim() {
        if !GameManager.sharedInstance.gameOver {
            self.removeAllActions()
            self.runAction(GameManager.sharedInstance.gameOverSoundAction)
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