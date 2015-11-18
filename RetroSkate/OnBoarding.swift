//
//  OnBoarding.swift
//  RetroSkate
//
//  Created by Nicholas Pettas on 11/17/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit
import AVFoundation

class OnBoarding: SKScene {
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        let tap = UITapGestureRecognizer(target: self, action: "tapped:")
        self.view?.addGestureRecognizer(tap)
        
        setup()
    }
    
    func setup() {
        backgroundColor = GameManager.sharedInstance.BACKGROUND_COLOR

        // Add title
        let title = SKLabelNode(fontNamed: "PressStart2P-Regular")
        title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 410)
        title.text = "Instructions"
        title.fontSize = 48
        addChild(title)
        
        // add images
        let tapRemoteImage = SKSpriteNode(imageNamed: "remote_jump")
        let swipeLeftRemoteImage = SKSpriteNode(imageNamed: "remote_swipe_left")
        let swipeRightRemoteImage = SKSpriteNode(imageNamed: "remote_swipe_right")
        tapRemoteImage.position = CGPointMake(CGRectGetMidX(self.frame) - 500, CGRectGetMidY(self.frame) - 30)
        swipeLeftRemoteImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 30)
        swipeRightRemoteImage.position = CGPointMake(CGRectGetMidX(self.frame) + 500, CGRectGetMidY(self.frame) - 30)
        addChild(tapRemoteImage)
        addChild(swipeLeftRemoteImage)
        addChild(swipeRightRemoteImage)

        // add labels
        let tapLabel = SKLabelNode(fontNamed: "PressStart2P-Regular")
        let swipeLeftLabel = SKLabelNode(fontNamed: "PressStart2P-Regular")
        let swipeRIghtLabel = SKLabelNode(fontNamed: "PressStart2P-Regular")
        tapLabel.position = CGPointMake(CGRectGetMidX(self.frame) - 500, CGRectGetMidY(self.frame) + 290)
        swipeLeftLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 290)
        swipeRIghtLabel.position = CGPointMake(CGRectGetMidX(self.frame) + 500, CGRectGetMidY(self.frame) + 290)
        tapLabel.text = "Jump"
        swipeLeftLabel.text = "Flip"
        swipeRIghtLabel.text = "Ollie"
        addChild(tapLabel)
        addChild(swipeLeftLabel)
        addChild(swipeRIghtLabel)
        
        // continue label
        let continueLabel = SKLabelNode(fontNamed: "PressStart2P-Regular")
        continueLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 430)
        continueLabel.text = "Tap to continue"
        continueLabel.fontSize = 36
        addChild(continueLabel)
        let fadeIn = SKAction.fadeInWithDuration(0.8)
        let fadeOut = SKAction.fadeOutWithDuration(0.8)
        let wait = SKAction.waitForDuration(0.5)
        continueLabel.runAction(SKAction.repeatActionForever(SKAction.sequence([fadeIn, wait, fadeOut])))
    }
    
    func tapped(tap: UITapGestureRecognizer) {
        NSNotificationCenter.defaultCenter().postNotificationName("loadLevelOne", object: nil)
    }
}