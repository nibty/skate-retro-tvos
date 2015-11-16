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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed: "GameScene") {
            
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
                scene.scaleMode = .AspectFit
                scene.anchorPoint = CGPointMake(0, -0.1)
                
            #else
                // setup display for iphones and ipads
                scene.scaleMode = .ResizeFill
                
                if Utils.getPhoneSize().width <= 414 {
                    
                    if Utils.isLandscape() {
                        scene.anchorPoint = CGPointMake(0, -0.2)
                    }
                } else {
                    if Utils.isLandscape() {
                        scene.anchorPoint = CGPointMake(0, 0.0)
                    }
                }
            #endif
            
            skView.presentScene(scene)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
