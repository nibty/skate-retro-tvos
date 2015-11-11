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
    let ASP_PIECES = 15
    let SIDEWALK_PIECES = 24
    let GROUND_X_RESET: CGFloat = -150
    var sidewalkPices = [Ground]()
    var asphaltPieces = [Ground]()

    override func update() {
        for var i = 0; i < asphaltPieces.count; i++ {
            updateGround(asphaltPieces, groundIndex: i)
        }
        
        for var i = 0; i < sidewalkPices.count; i++ {
            updateGround(sidewalkPices, groundIndex: i)
        }
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
        
        let floor = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(1080, 2))
            
        floor.position = CGPointMake(540, 115)
        floor.physicsBody = SKPhysicsBody(rectangleOfSize: floor.size)
        floor.physicsBody?.dynamic = false
        self.addChild(floor)
    }
    
    func setupGroud(grounds: [Ground], index: Int) {
        if index == 0 {
            grounds[index].position = CGPointMake(0, grounds[index].yPos)
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