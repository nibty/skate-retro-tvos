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

    var musicPlayer: AVAudioPlayer!
    var gameOverLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!

    override func didMoveToView(view: SKView) {
        let tap = UITapGestureRecognizer(target: self, action: "tapped:")
        tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
        self.view?.addGestureRecognizer(tap)
        
        let swipeRecognizerRight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeRecognizerRight.direction = .Right
        self.view?.addGestureRecognizer(swipeRecognizerRight)

        let swipeRecognizerLeft = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeRecognizerLeft.direction = .Left
        self.view?.addGestureRecognizer(swipeRecognizerLeft)
        
        self.physicsWorld.gravity = CGVectorMake(0.0, -10)
        self.physicsWorld.contactDelegate = self
        
        startGame()
    }
    
    func startGame() {
        playLevelMusic()
        
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
        
        player = Player()
        self.addChild(player)
        
        background = Backgrounds()
        background.setup()
        self.addChild(background)
        
        ground = Grounds()
        ground.setup();
        self.addChild(ground)
        
        gameOverLabel = SKLabelNode(fontNamed: "Arial")
        gameOverLabel.fontSize = 40
        gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        gameOverLabel.zPosition = 9
        self.addChild(gameOverLabel)
      
        GameManager.sharedInstance.score = 0
        scoreLabel = SKLabelNode(fontNamed: "Arial")
        scoreLabel.fontSize = 40
        scoreLabel.position = CGPointMake(950, 600)
        scoreLabel.zPosition = 9
        scoreLabel.text = "0"
        self.addChild(scoreLabel)
        
        for var i = 0; i < 3; i++ {
            let wait = SKAction.waitForDuration(2.0 * Double(i))
            self.runAction(wait, completion:  {() -> Void in
                let building = Building()
                self.scenery.append(building)
                self.addChild(building);
                building.startMoving()
            })
        }
                
        for var i = 1; i < 3; i++ {
            let wait = SKAction.waitForDuration(2.3 * Double(i))
            self.runAction(wait, completion:  {() -> Void in
                let tree = Tree()
                self.scenery.append(tree)
                self.addChild(tree);
                tree.startMoving()
            })
        }
        
        let cloud = Cloud()
        cloud.movingSpeed = -0.2
        cloud.startPosition = 100
        self.scenery.append(cloud)
        self.addChild(cloud);
        cloud.startMoving()
        
        let cloud2 = Cloud()
        cloud2.movingSpeed = -0.2
        cloud2.startPosition = 800
        self.scenery.append(cloud2)
        self.addChild(cloud2);
        cloud2.startMoving()
    }
    

    
    func restartGame() {
        player = nil
        background = nil
        ground = nil
        scenery = [SKSpriteNode]()
        obstacles = [SKSpriteNode]()
        musicPlayer = nil
        gameOverLabel = nil
        
        self.removeAllChildren()
        GameManager.sharedInstance.gameOver = false

        self.startGame()
    }
    

    override func update(currentTime: CFTimeInterval) {
        scoreLabel.text = String(GameManager.sharedInstance.score)
        
        for child in self.children {
            child.update()
        }
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
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == GameManager.sharedInstance.COLLIDER_OBSTACLE || contact.bodyB.categoryBitMask == GameManager.sharedInstance.COLLIDER_OBSTACLE {
            
            musicPlayer.stop()

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
        
        else if contact.bodyA.categoryBitMask == GameManager.sharedInstance.COLLIDER_RIDEABLE || contact.bodyB.categoryBitMask == GameManager.sharedInstance.COLLIDER_RIDEABLE  {
            print("contact")
            GameManager.sharedInstance.isJumping = false
        }
    }
    
    func playLevelMusic() {
        let levelMusicURL = NSBundle.mainBundle().URLForResource("musicMain", withExtension: "wav")
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: levelMusicURL!)
            musicPlayer.numberOfLoops = -1
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        } catch {
            
        }
    }
    
    func gameOver() {
        GameManager.sharedInstance.gameOver = true
        gameOverLabel.text = "Game Over"
    }
    
    func randomNumber() -> Double {
        return Double(Double(arc4random()) / Double(UINT32_MAX)) + 1
    }
    
    func randomStart(lastStart: CGFloat) -> CGFloat {
        let lower : UInt32 = 1000
        let upper : UInt32 = 1800
        
        var random = CGFloat(arc4random_uniform(upper - lower) + lower)
        
        let diff = abs(random - lastStart)
        
        
        if diff < 200 {
            random += (200 - diff)
        }
        
        return random
    }
}





























