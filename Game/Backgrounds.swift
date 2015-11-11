//
//  Backgrounds.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class Backgrounds: SKNode {

    var farBG = [Background]()
    var midBG = [Background]()
    var frontBG = [Background]()
    var backgroundActions = [SKAction]()
    let BG_X_RESET: CGFloat = -920
    
    override func update() {
        for var i = 0; i < 3; i++ {
            updateBackground(farBG, backgroundIndex: i)
            updateBackground(midBG, backgroundIndex: i)
            updateBackground(frontBG, backgroundIndex: i)
        }
    }
    
    func setup() {
        for var x = 0; x < 3; x++ {
            let frontBackground = FrontBG()
            setupBackground(frontBackground, index: x)
            frontBG.append(frontBackground)

            let midBackground = MidBG()
            setupBackground(midBackground, index: x)
            midBG.append(midBackground)
            
            let farBackground = FarBG()
            setupBackground(farBackground, index: x)
            farBG.append(farBackground)
        }
    }
    
    func updateBackground(backgrounds: [Background], backgroundIndex: Int) {
        if backgrounds[backgroundIndex].position.x <= BG_X_RESET {
            var index: Int!
            
            if backgroundIndex == 0 {
                index = backgrounds.count - 1
            } else {
                index = backgroundIndex - 1
            }
            
            let newPost = CGPointMake(backgrounds[index].position.x + backgrounds[backgroundIndex].size.width, backgrounds[index].position.y)
            backgrounds[backgroundIndex].position = newPost
        }
    }

    func setupBackground(background: Background, index: Int) {
        background.position = CGPointMake(CGFloat(index) * background.size.width, background.yPos)
        self.addChild(background)
    }
}
