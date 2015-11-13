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
    var sidewalkPices = [Ground]()
    var frontSidewalkPices = [Ground]()
    var asphaltPieces = [Ground]()

    override func update() {
        
        // Update asphalt
        for var i = 0; i < asphaltPieces.count; i++ {
            updateGround(asphaltPieces, groundIndex: i)
        }
        
        // Update sidewalk
        for var i = 0; i < sidewalkPices.count; i++ {
            updateGround(sidewalkPices, groundIndex: i)
        }
    }

    func setup() {
        
        // Setup asphalt pieces
        for var i = 0; i < GameManager.sharedInstance.ASP_PIECES; i++ {
            let asphalt = Asphalt()
            asphalt.startMoving()
            asphaltPieces.append(asphalt)
            setupGroud(asphaltPieces, index: i)
            self.addChild(asphalt)
        }
        
        // Setup sidewalk pieces
        for var i = 0; i < GameManager.sharedInstance.SIDEWALK_PIECES; i++ {
            let sidewalk = Sidewalk()
            sidewalk.startMoving()
            sidewalkPices.append(sidewalk)
            setupGroud(sidewalkPices, index: i)
            self.addChild(sidewalk)
        }
        
        // Setup floor collider so the player will not fall through
        let floor = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeMake(GameManager.sharedInstance.FLOOR_WIDTH, GameManager.sharedInstance.FLOOR_HEIGHT))
        self.addChild(floor)
        floor.position = CGPointMake(GameManager.sharedInstance.FLOOR_POSITION_X, GameManager.sharedInstance.FLOOR_POSITION_Y)
        floor.physicsBody = SKPhysicsBody(rectangleOfSize: floor.size)
        floor.physicsBody!.categoryBitMask = GameManager.sharedInstance.COLLIDER_RIDEABLE
        floor.physicsBody!.contactTestBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
        floor.physicsBody?.dynamic = false
    }
    
    func setupGroud(grounds: [Ground], index: Int) {
        if index == 0 {
            grounds[index].position = CGPointMake(GameManager.sharedInstance.GROUND_X_RESET, grounds[index].yPos)
        } else {
            grounds[index].position = CGPointMake(grounds[index].size.width + grounds[index - 1].position.x, grounds[index - 1].position.y)
        }
    }
    
    func updateGround(grounds: [Ground], groundIndex: Int) {
        var index: Int!
        
        if grounds[groundIndex].position.x <= GameManager.sharedInstance.GROUND_X_RESET {
            
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