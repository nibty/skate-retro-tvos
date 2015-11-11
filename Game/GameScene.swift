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
    var buildings = [SKSpriteNode]()
    var obstacles = [SKSpriteNode]()
    var musicPlayer: AVAudioPlayer!
    var gameOverLabel: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        let tap = UITapGestureRecognizer(target: self, action: "tapped:")
        tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
        self.view?.addGestureRecognizer(tap)
        
        startGame()

        self.physicsWorld.gravity = CGVectorMake(0.0, -10)
        self.physicsWorld.contactDelegate = self
        
    }
    
    func startGame() {
        playLevelMusic()
        
        for var i = 0; i < 3; i++ {
            
            let wait = SKAction.waitForDuration(randomNumber() * Double(i))
            self.runAction(wait, completion:  {() -> Void in
                let startPosition = self.randomStart()
                
                let dumpster = Dumpster()
                dumpster.startPosition = startPosition
                self.addChild(dumpster)
                self.obstacles.append(dumpster)
                
                let dumbsterTop = DumbsterTop()
                self.addChild(dumbsterTop)
                dumbsterTop.startPosition = dumpster.startPosition

                dumbsterTop.position = CGPointMake(dumpster.position.x, dumpster.position.y + 50)
                self.obstacles.append(dumbsterTop)
                
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
        
        for var i = 0; i < 3; i++ {
            let wait = SKAction.waitForDuration(2.0 * Double(i))
            self.runAction(wait, completion:  {() -> Void in
                let building = Building()
                self.buildings.append(building)
                self.addChild(building);
                building.startMoving()
            })
        }
        
        buildings.append(Building())
    }
    
    func restartGame() {
        player = nil
        background = nil
        ground = nil
        buildings = [SKSpriteNode]()
        obstacles = [SKSpriteNode]()
        musicPlayer = nil
        gameOverLabel = nil
        
        self.removeAllChildren()
        GameManager.sharedInstance.gameOver = false

        self.startGame()
    }
    

    override func update(currentTime: CFTimeInterval) {
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
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == GameManager.sharedInstance.COLLIDER_OBSTACLE || contact.bodyB.categoryBitMask == GameManager.sharedInstance.COLLIDER_OBSTACLE {
            
            musicPlayer.stop()

            self.removeAllActions()
            self.background.removeAllActions()
            self.ground.removeAllActions()
            
            for obstacle in obstacles {
                obstacle.removeAllActions()
            }
            
            for bld in buildings {
                bld.removeAllActions()
            }
            
            player.playCrashAnim()
            
            gameOver()
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
    
    func randomStart() -> CGFloat {
        let lower : UInt32 = 1300
        let upper : UInt32 = 1800
        return CGFloat(arc4random_uniform(upper - lower) + lower)
    }
}





























