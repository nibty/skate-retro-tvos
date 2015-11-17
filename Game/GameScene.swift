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
    
    var obstacleTypes: [Obstacle.Type] = [Dumpster.self, Ledge.self, Rail.self]
    var obstacles = [SKSpriteNode]()
    var scenery = [SKSpriteNode]()

    var gameOverLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    var currentScoreLabel: SKLabelNode!
    var topScoreLabel: SKLabelNode!
    
    var currentScore: Int = 0 {
        didSet {
            currentScoreLabel.text = "Score: \(currentScore)"
        }
    }
    
    var topScore: Int = 0 {
        didSet {
            topScoreLabel.text = "Best: \(topScore)"
        }
    }
    
    override func didMoveToView(view: SKView) {
        
        // Setup player controls
        let tap = UITapGestureRecognizer(target: self, action: "tapped:")
        let swipeRecognizerRight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        let swipeRecognizerLeft = UISwipeGestureRecognizer(target: self, action: "swipedLeft:")
        swipeRecognizerRight.direction = .Right
        swipeRecognizerLeft.direction = .Left
        #if TARGET_OS_TV
            tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
        #endif
        
        self.view?.addGestureRecognizer(tap)
        self.view?.addGestureRecognizer(swipeRecognizerRight)
        self.view?.addGestureRecognizer(swipeRecognizerLeft)
        
        // Setup world physics
        self.physicsWorld.gravity = CGVectorMake(0.0, GameManager.sharedInstance.GRAVITY_Y)
        self.physicsWorld.contactDelegate = self
        
        startGame()
    }
    
    override func update(currentTime: CFTimeInterval) {
        currentScore = GameManager.sharedInstance.score

        for child in self.children {
            child.update()
        }
    }   

    func addObsticle() {
        let randomIndex = Int(arc4random_uniform(UInt32(self.obstacleTypes.count)))
        let obsticleType = self.obstacleTypes[randomIndex]
        let obsticle = obsticleType.init()
        self.addChild(obsticle)
        self.obstacles.append(obsticle)
        obsticle.startMoving()
    }
    
    func addTree() {
        let tree = Tree()
        self.scenery.append(tree)
        self.addChild(tree);
        tree.startPosition = 2100
        tree.startMoving()
    }
    
    func addBuilding() {
        let building = Building()
        self.scenery.append(building)
        self.addChild(building);
        building.startMoving()
    }
    
    func addFireHydrant() {
        let fireHydrant = FireHydrant()
        self.scenery.append(fireHydrant)
        self.addChild(fireHydrant);
        fireHydrant.startPosition = 2400
        fireHydrant.startMoving()
    }
    
    func addCloud() {
        let cloud = Cloud()
        cloud.movingSpeed = -0.2
        cloud.startPosition = 800
        self.scenery.append(cloud)
        self.addChild(cloud);
        cloud.startMoving()
    }
    
    func callActionAtRandomTimes(min: Float, max: Float, action: () -> Void) {
        let difficulty = NSTimeInterval(Float.random(min: min, max: max))
        
        let waitAction = SKAction.waitForDuration(difficulty)
        let addAction = SKAction.runBlock { () -> Void in
            action()
        }
        
        let actionMoveDone = SKAction.removeFromParent()

        runAction(SKAction.sequence([addAction, waitAction, actionMoveDone]), completion: { () -> Void in
            self.callActionAtRandomTimes(min, max: max, action: action)
        })
    }
    
    func startGame() {
        self.backgroundColor = GameManager.sharedInstance.BACKGROUND_COLOR
        
        setupScore()

        AudioManager.sharedInstance.playMusic(self)

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
        gameOverLabel = SKLabelNode(fontNamed: "San Francisco")
        gameOverLabel.fontSize = 40
        gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        gameOverLabel.zPosition = 9
        self.addChild(gameOverLabel)
        
        // Add obsticles
        callActionAtRandomTimes(0.5, max: 2.8, action: {
            self.addObsticle()
            })
        
        // Add buildings
        callActionAtRandomTimes(1.5, max: 2.5, action: {
            self.addBuilding()
        })
        
        // Trees
        callActionAtRandomTimes(2, max: 3, action: {
            self.addTree()
        })
        
        // Add some fire Hydrants
        callActionAtRandomTimes(7, max: 14, action: {
            self.addFireHydrant()
        })
        
        // Add come clouds
        callActionAtRandomTimes(60, max: 120, action: {
            self.addCloud()
        })
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
        AudioManager.sharedInstance.stopMusic()
        
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
            player.physicsBody?.applyImpulse(CGVectorMake(-15, 2))
            stopGame()
        }
            
        // Contact on skateable surface
        else if contact.bodyA.categoryBitMask == GameManager.sharedInstance.COLLIDER_RIDEABLE || contact.bodyB.categoryBitMask == GameManager.sharedInstance.COLLIDER_RIDEABLE  {
            player.isJumping = false
            
            // Crash detected. End game
            if (player.isOllieTrick || player.isFlipTrick) {
                player.isOllieTrick = false
                player.isFlipTrick = false
                
                stopGame()
            }
        }
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
            currentScoreLabel.position = CGPointMake(GameManager.sharedInstance.SCORE_POSITION_X_APPLETV, GameManager.sharedInstance.SCORE_POSITION_Y_APPLETV)
            topScoreLabel.position = CGPointMake(GameManager.sharedInstance.SCORE_POSITION_X_APPLETV, GameManager.sharedInstance.SCORE_POSITION_Y_APPLETV - 50)

        #else

            // iphone landscape
        if isLandscape() && Utils.getPhoneSize().width <= GameManager.sharedInstance.IPHONE_PLUS_WIDTH {
            currentScoreLabel.position = CGPointMake(size.width + GameManager.sharedInstance.SCORE_X_ADJUSTMENT_POS_LANDSCAPE, size.height + GameManager.sharedInstance.SCORE_Y_ADJUSTMENT_POS_LANDSCAPE)
            topScoreLabel.position = CGPointMake(size.width + GameManager.sharedInstance.SCORE_X_ADJUSTMENT_POS_LANDSCAPE, size.height + GameManager.sharedInstance.SCORE_Y_ADJUSTMENT_POS_LANDSCAPE - 40)
      
            // ipad landscape
        } else if isLandscape() && Utils.getPhoneSize().width > GameManager.sharedInstance.IPHONE_PLUS_WIDTH {
                currentScoreLabel.position = CGPointMake(size.width + GameManager.sharedInstance.SCORE_X_ADJUSTMENT_POS_PORTRAIT, size.height + GameManager.sharedInstance.SCORE_Y_ADJUSTMENT_POS_PORTRAIT)
            topScoreLabel.position = CGPointMake(size.width + GameManager.sharedInstance.SCORE_X_ADJUSTMENT_POS_PORTRAIT, size.height + GameManager.sharedInstance.SCORE_Y_ADJUSTMENT_POS_PORTRAIT - 40)
        }
            
        #endif
    }
    
    func setupScore() {

        // Add score label
        currentScoreLabel = SKLabelNode(fontNamed: "San Francisco")
        currentScoreLabel.fontSize = 30
        currentScoreLabel.zPosition = 9
        currentScoreLabel.horizontalAlignmentMode = .Right
        self.addChild(currentScoreLabel)
        
        topScoreLabel = SKLabelNode(fontNamed: "San Francisco")
        topScoreLabel.fontSize = 30
        topScoreLabel.zPosition = 9
        topScoreLabel.horizontalAlignmentMode = .Right
        self.addChild(topScoreLabel)
        placeScoreLabel()
        
        let userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if userDefaults.valueForKey(GameManager.sharedInstance.TOP_SCORE_STORAGE_KEY) == nil {
            userDefaults.setInteger(0, forKey: GameManager.sharedInstance.TOP_SCORE_STORAGE_KEY)
            userDefaults.synchronize()
        }
        
        if currentScore > topScore {
            NSUserDefaults.standardUserDefaults().setInteger(currentScore, forKey: GameManager.sharedInstance.TOP_SCORE_STORAGE_KEY)
            NSUserDefaults.standardUserDefaults().synchronize()
            topScore = currentScore
        } else {
            topScore = NSUserDefaults.standardUserDefaults().objectForKey(GameManager.sharedInstance.TOP_SCORE_STORAGE_KEY) as! Int
        }
    }
}





























