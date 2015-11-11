//
//  GameScene.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright (c) 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player:Player!
    var background:Backgrounds!
    var ground:Grounds!

    override func didMoveToView(view: SKView) {
        let tap = UITapGestureRecognizer(target: self, action: "tapped:")
        tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
        self.view?.addGestureRecognizer(tap)
        
        let dumpster = Dumpster()
        self.addChild(dumpster)
        dumpster.startMoving()
        
        player = Player()
        self.addChild(player)
        
        background = Backgrounds()
        background.setup()
        self.addChild(background)

        ground = Grounds()
        ground.setup();
        self.addChild(ground)

        self.physicsWorld.gravity = CGVectorMake(0.0, -10)
        self.physicsWorld.contactDelegate = self
    }
   
    override func update(currentTime: CFTimeInterval) {
        for child in self.children {
            child.update()
        }
    }

    func tapped(gesture: UIGestureRecognizer) {
        player.jump()
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == GameManager.sharedInstance.COLLIDER_OBSTACLE || contact.bodyB.categoryBitMask == GameManager.sharedInstance.COLLIDER_OBSTACLE {
            print("hit a obstackle")
        }
    }
}





























