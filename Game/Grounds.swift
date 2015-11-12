//
//  Grounds.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class Grounds: SKNode {
    
    // Ground setup
    let ASP_PIECES = 25
    let SIDEWALK_PIECES = 35
    let GROUND_X_RESET: CGFloat = -150
    var sidewalkPices = [Ground]()
    var frontSidewalkPices = [Ground]()
    var asphaltPieces = [Ground]()

    override func update() {
        for var i = 0; i < asphaltPieces.count; i++ {
            updateGround(asphaltPieces, groundIndex: i)
        }
        
        for var i = 0; i < sidewalkPices.count; i++ {
            updateGround(sidewalkPices, groundIndex: i)
        }
        
//        for var i = 0; i < frontSidewalkPices.count; i++ {
//            updateGround(frontSidewalkPices, groundIndex: i)
//        }
    }

    func setup() {
        for var i = 0; i < ASP_PIECES; i++ {
            let asphalt = Asphalt()
            asphalt.startMoving()
            asphaltPieces.append(asphalt)
            setupGroud(asphaltPieces, index: i)
            self.addChild(asphalt)
        }
        
        for var i = 0; i < SIDEWALK_PIECES; i++ {
            let sidewalk = Sidewalk()
            sidewalk.startMoving()
            sidewalkPices.append(sidewalk)
            setupGroud(sidewalkPices, index: i)
            self.addChild(sidewalk)
        }
        
//        if Utils.getPhoneSize().width <= 414 {
//            for var i = 0; i < SIDEWALK_PIECES; i++ {
//                let frontSidewalk = Sidewalk()
//                frontSidewalk.yPos = -55
//                frontSidewalk.startMoving()
//                frontSidewalkPices.append(frontSidewalk)
//                setupGroud(frontSidewalkPices, index: i)
//                self.addChild(frontSidewalk)
//            }
//        }
        
        let floor = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeMake(1080, 5))
        self.addChild(floor)
        floor.position = CGPointMake(540, 115)
        floor.physicsBody = SKPhysicsBody(rectangleOfSize: floor.size)
        floor.physicsBody!.categoryBitMask = GameManager.sharedInstance.COLLIDER_RIDEABLE
        floor.physicsBody!.contactTestBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
        floor.physicsBody?.dynamic = false
    }
    
    func setupGroud(grounds: [Ground], index: Int) {
        if index == 0 {
            grounds[index].position = CGPointMake(-200, grounds[index].yPos)
        } else {
            grounds[index].position = CGPointMake(grounds[index].size.width + grounds[index - 1].position.x, grounds[index - 1].position.y)
        }
    }
    
    func updateGround(grounds: [Ground], groundIndex: Int) {
        var index: Int!
        
        if grounds[groundIndex].position.x <= GROUND_X_RESET {
            
            if groundIndex == 0 {
                index = grounds.count - 1
            } else {
                index = groundIndex - 1
            }
            
            let newPost = CGPointMake(grounds[index].position.x + grounds[groundIndex].size.width, grounds[index].position.y)
            
            grounds[groundIndex].position = newPost
        }
    }
    
    override func removeAllActions() {
        super.removeAllActions()
        
        for node in sidewalkPices {
            node.removeAllActions()
        }
        
        for node in asphaltPieces {
            node.removeAllActions()
        }
    }
}