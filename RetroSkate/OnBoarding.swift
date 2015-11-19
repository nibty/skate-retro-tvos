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
    
    var partOneShown = false
    var graphic: SKSpriteNode!
    var label: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        backgroundColor = UIColor.blackColor()

        let tap = UITapGestureRecognizer(target: self, action: "tapped")
        let swipe = UISwipeGestureRecognizer(target: self, action: "tapped")
        self.view?.addGestureRecognizer(swipe)
        self.view?.addGestureRecognizer(tap)
        
        #if os(tvOS)
            partOneShown = true
            setupAppleTv()
        #else
            setupIphone()
        #endif
    }
    
    func setupIphone() {

        // Add title
        let title = SKLabelNode(fontNamed: "SanFranciscoText-Regular")
        title.text = "Instructions"
        title.fontSize = 36
        addChild(title)
        
        // label
        label = SKLabelNode(fontNamed: "SanFranciscoText-Regular")
        label.text = "Tap screen to Jump"
        label.fontSize = 24
        addChild(label)

        // image
        graphic = SKSpriteNode(imageNamed: "onboarding-tap")
        graphic.position = CGPointMake(self.frame.width / 2, self.frame.height / 2)
        graphic.size = CGSize(width: 50, height: 50)
        addChild(graphic)
        
        title.position = CGPointMake(self.frame.width / 2, self.frame.height - 60)
        label.position = CGPointMake(self.frame.width / 2, self.frame.height - 100)
        
        let continueLabel = SKLabelNode(fontNamed: "SanFranciscoText-Regular")
        continueLabel.position = CGPointMake(self.frame.width / 2, 40)
        continueLabel.text = "Continue"
        continueLabel.fontSize = 20
        addChild(continueLabel)
        let fadeIn = SKAction.fadeInWithDuration(0.8)
        let fadeOut = SKAction.fadeOutWithDuration(0.8)
        let wait = SKAction.waitForDuration(0.5)
        continueLabel.runAction(SKAction.repeatActionForever(SKAction.sequence([fadeIn, wait, fadeOut])))
    }
    
    func iphonePartTwo() {
        graphic.removeFromParent()
        
        // image
        let tapGraphic = SKSpriteNode(imageNamed: "onboarding-swipe")
        tapGraphic.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 20)
        tapGraphic.size = CGSize(width: 325, height: 27)
        addChild(tapGraphic)

        label.text = "While in the air,"

        let secountLabel = SKLabelNode(fontNamed: "SanFranciscoText-Regular")
        secountLabel.text = "swipe to perform tricks"
        secountLabel.fontSize = 24
        addChild(secountLabel)
        secountLabel.position = CGPointMake(self.frame.width / 2, self.frame.height - 125)
    }
    
    func setupAppleTv() {
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
    
    
    func tapped() {
        if !partOneShown {
            partOneShown = true
            iphonePartTwo()
            
        } else {
            NSNotificationCenter.defaultCenter().postNotificationName("nextScene", object: nil)
        }
    }
}