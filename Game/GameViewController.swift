//
//  GameViewController.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright (c) 2015 Nicholas Pettas. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var scene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed: "GameScene") {
            self.scene = scene
            
            // Configure the view.
            let skView = self.view as! SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
//            skView.showsPhysics = true
//
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            #if os(tvOS)
                // Set up for apple tv
                self.scene.scaleMode = .AspectFit
                self.scene.anchorPoint = CGPointMake(0, -0.1)
                
            #else
                self.scene.scaleMode = .ResizeFill
                
                // setup display for iphones
                if Utils.getPhoneSize().width <= 414 {
                    
                    if Utils.isLandscape() {
                        self.scene.anchorPoint = CGPointMake(0, -0.2)
                    }
                } else {
                    if Utils.isLandscape() {
                        self.scene.anchorPoint = CGPointMake(0, 0.0)
                    }
                }
                
            #endif
            
            skView.presentScene(self.scene)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
