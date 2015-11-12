//
//  Utils.swift
//  Game
//
//  Created by Nicholas Pettas on 11/10/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import SpriteKit

class Utils {
    static func randomStart() -> CGFloat {
        let lower : UInt32 = 1000
        let upper : UInt32 = 1500
        
        let random = CGFloat(arc4random_uniform(upper - lower) + lower)
        
        return random
    }
    
    static func getPhoneSize() -> CGRect {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
    
        return screenSize
    }
}
