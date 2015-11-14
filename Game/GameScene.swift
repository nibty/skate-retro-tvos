//
//  GameScene.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright (c) 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player:Player!
    var background:Backgrounds!
    var ground:Grounds!
    
    var obstacles = [SKSpriteNode]()
    var scenery = [SKSpriteNode]()

    var gameOverLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        
        // Setup player controls
        let tap = UITapGestureRecognizer(target: self, action: "tapped:")
        let swipeRecognizerRight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        let swipeRecognizerLeft = UISwipeGestureRecognizer(target: self, action: "swipedLeft:")
        swipeRecognizerRight.direction = .Right
        swipeRecognizerLeft.direction = .Left
        self.view?.addGestureRecognizer(tap)
        self.view?.addGestureRecognizer(swipeRecognizerRight)
        self.view?.addGestureRecognizer(swipeRecognizerLeft)
        
        // Setup world physics
        self.physicsWorld.gravity = CGVectorMake(0.0, GameManager.sharedInstance.GRAVITY_Y)
        self.physicsWorld.contactDelegate = self
        
        startGame()
    }
    
    override func update(currentTime: CFTimeInterval) {
        scoreLabel.text = String(GameManager.sharedInstance.score)
        
        for child in self.children {
            child.update()
        }
    }
    
    func startGame() {
        self.backgroundColor = GameManager.sharedInstance.BACKGROUND_COLOR

        playLevelMusic()

        // Add obsticals
        for var i = 1; i < 4; i++ {
            let wait = SKAction.waitForDuration(1.8 * Double(i))
            self.runAction(wait, completion:  {() -> Void in

            let dumpster = Dumpster()
            let dumbsterTop = DumbsterTop()

            self.addChild(dumpster)
            self.addChild(dumbsterTop)
            dumbsterTop.position = CGPointMake(dumpster.position.x, dumpster.position.y + 50)
            self.obstacles.append(dumbsterTop)
            self.obstacles.append(dumpster)
            dumpster.startMoving()
            dumbsterTop.startMoving()
            })
        }
        
        // Add Player
        player = Player()
        self.addChild(player)
        
        // Add backgrounds
        background = Backgrounds()
        background.setup()
        self.addChild(background)
        
        // Add ground
        ground = Grounds()
        ground.setup()
        self.addChild(ground)
        
        // Add gameover label
        gameOverLabel = SKLabelNode(fontNamed: "Arial")
        gameOverLabel.fontSize = 40
        gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        gameOverLabel.zPosition = 9
        self.addChild(gameOverLabel)
      
        // Add score label
        scoreLabel = SKLabelNode(fontNamed: "Arial")
        scoreLabel.fontSize = 40
        placeScoreLabel()
        scoreLabel.zPosition = 9
        scoreLabel.text = "0"
        self.addChild(scoreLabel)
        
        // Add buildings
        for var i = 0; i < 3; i++ {
            let wait = SKAction.waitForDuration(2.0 * Double(i))
            self.runAction(wait, completion:  {() -> Void in
                let building = Building()
                self.scenery.append(building)
                self.addChild(building);
                building.startMoving()
            })
        }
        
        // Add some trees
        for var i = 1; i < 3; i++ {
            let wait = SKAction.waitForDuration(2.3 * Double(i))
            self.runAction(wait, completion:  {() -> Void in
                let tree = Tree()
                self.scenery.append(tree)
                self.addChild(tree);
                tree.startMoving()
            })
        }
        
        // Add clouds
        for var i = 0; i < 2; i++ {
            let cloud = Cloud()
            cloud.movingSpeed = -0.2
            if (i == 1) {
                cloud.startPosition = 100
            } else {
                cloud.startPosition = 800
            }
            self.scenery.append(cloud)
            self.addChild(cloud);
            cloud.startMoving()
        }
    }
    
    func restartGame() {
        GameManager.sharedInstance.gameOver = false
        GameManager.sharedInstance.score = 0

        player = nil
        background = nil
        ground = nil
        scenery = [SKSpriteNode]()
        obstacles = [SKSpriteNode]()
        gameOverLabel = nil
        
        self.removeAllChildren()

        self.startGame()
    }
    
    func stopGame() {
        stopMusic()
        
        self.removeAllActions()
        self.background.removeAllActions()
        self.ground.removeAllActions()
        
        for obstacle in obstacles {
            obstacle.removeAllActions()
        }
        
        for scene in scenery {
            scene.removeAllActions()
        }
        
        player.playCrashAnim()
        
        gameOver()
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        // Crash detected. End game
        if contact.bodyA.categoryBitMask == GameManager.sharedInstance.COLLIDER_OBSTACLE || contact.bodyB.categoryBitMask == GameManager.sharedInstance.COLLIDER_OBSTACLE {
            stopGame()
        }
            
        // Contact on skateable surface
        else if contact.bodyA.categoryBitMask == GameManager.sharedInstance.COLLIDER_RIDEABLE || contact.bodyB.categoryBitMask == GameManager.sharedInstance.COLLIDER_RIDEABLE  {
            GameManager.sharedInstance.isJumping = false
            GameManager.sharedInstance.isTricking = false
        }
    }
    
    func playLevelMusic() {
        self.addChild(AudioManager.sharedInstance.backgroundMusic)
    }
    
    func stopMusic() {
        AudioManager.sharedInstance.backgroundMusic.removeFromParent()
    }
    
    func gameOver() {
        GameManager.sharedInstance.gameOver = true
        gameOverLabel.text = "Game Over"
    }
    
    func tapped(gesture: UIGestureRecognizer) {
        if !GameManager.sharedInstance.gameOver {
            player.jump()
        } else {
            restartGame()
        }
    }
    
    func swiped(gesture: UIGestureRecognizer) {
        if !GameManager.sharedInstance.gameOver {
            player.ollie()
        } else {
            restartGame()
        }
    }
    
    func swipedLeft(gesture: UIGestureRecognizer) {
        if !GameManager.sharedInstance.gameOver {
            player.flip()
        } else {
            restartGame()
        }
    }
    
    override func didChangeSize(oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        if (self.size.height < self.size.width) {
            self.view?.scene?.anchorPoint = CGPointMake(0, -0.2)
        } else {
            self.view?.scene?.anchorPoint = CGPointMake(0, 0)
        }
        
        if let _ = scoreLabel {
            placeScoreLabel()
        }
        
        if let label = gameOverLabel {
            label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        }
    }
    
    func isLandscape() -> Bool {
        return self.size.height < self.size.width
    }
    
    func placeScoreLabel() {
        let size = UIScreen.mainScreen().bounds.size
        
        // appletv
        #if os(tvOS)
            scoreLabel.position = CGPointMake(GameManager.sharedInstance.SCORE_POSITION_X_APPLETV, GameManager.sharedInstance.SCORE_POSITION_Y_APPLETV)
        #else

            // iphone landscape
        if isLandscape() && Utils.getPhoneSize().width <= GameManager.sharedInstance.IPHONE_PLUS_WIDTH {
            scoreLabel.position = CGPointMake(size.width + GameManager.sharedInstance.SCORE_X_ADJUSTMENT_POS_LANDSCAPE, size.height + GameManager.sharedInstance.SCORE_Y_ADJUSTMENT_POS_LANDSCAPE)
            self.scene!.anchorPoint = CGPointMake(0, -0.2)
            
            // iphone portrait
        } else if Utils.getPhoneSize().width <= GameManager.sharedInstance.IPHONE_PLUS_WIDTH {
            scoreLabel.position = CGPointMake(size.width + GameManager.sharedInstance.SCORE_X_ADJUSTMENT_POS_PORTRAIT, size.height + GameManager.sharedInstance.SCORE_Y_ADJUSTMENT_POS_PORTRAIT)
            self.scene!.anchorPoint = CGPointMake(0, 0.0)
        
            // ipad landscape
        } else if isLandscape() && Utils.getPhoneSize().width > GameManager.sharedInstance.IPHONE_PLUS_WIDTH {
                scoreLabel.position = CGPointMake(size.width + GameManager.sharedInstance.SCORE_X_ADJUSTMENT_POS_PORTRAIT, size.height + GameManager.sharedInstance.SCORE_Y_ADJUSTMENT_POS_PORTRAIT)
                self.scene!.anchorPoint = CGPointMake(0, 0.0)
       
            // ipad portrait
        } else {
            scoreLabel.position = CGPointMake(size.width + GameManager.sharedInstance.SCORE_X_ADJUSTMENT_POS_PORTRAIT, size.height + GameManager.sharedInstance.SCORE_Y_ADJUSTMENT_POS_PORTRAIT)
            self.scene!.anchorPoint = CGPointMake(0, 0.0)
        }
            
        #endif
    }
}





























