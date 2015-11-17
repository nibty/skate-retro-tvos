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
    
    static func getPhoneSize() -> CGSize {
        var screenSize: CGSize!
        
        if isLandscape() {
            screenSize = CGSizeMake(UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width)
        } else {
            screenSize = UIScreen.mainScreen().bounds.size
        }
        
        return screenSize
    }
    
    static func isLandscape() -> Bool {
        #if !os(tvOS)
            if UIScreen.mainScreen().bounds.size.width > UIScreen.mainScreen().bounds.size.height {
                return true
            }
        #endif
        
        return false
    }
}
