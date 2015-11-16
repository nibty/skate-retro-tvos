//
//  Random.swift
//  Game
//
//  Created by Nicholas Pettas on 11/15/15.
//  Copyright © 2015 Nicholas Pettas. All rights reserved.
//

import Foundation

import Foundation
import CoreGraphics

public extension Int {
    /**
     Returns a random integer between 0 and n-1.
     */
    public static func random(n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    /**
     Create a random num Int
     :param: min number Int
     :param: max number Int
     :return: random number Int
     By DaRkDOG
     */
    public static func random(min min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
}
public extension Double {
    /**
     Returns a random floating point number between 0.0 and 1.0, inclusive.
     By DaRkDOG
     */
    public static func random() -> Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
    /**
     Create a random num Double
     :param: min number Double
     :param: max number Double
     :return: random number Double
     By DaRkDOG
     */
    public static func random(min min: Double, max: Double) -> Double {
        return Double.random() * (max - min) + min
    }
}
public extension Float {
    /**
     Returns a random floating point number between 0.0 and 1.0, inclusive.
     By DaRkDOG
     */
    public static func random() -> Float {
        return Float(arc4random()) / 0xFFFFFFFF
    }
    /**
     Create a random num Float
     :param: min number Float
     :param: max number Float
     :return: random number Float
     By DaRkDOG
     */
    public static func random(min min: Float, max: Float) -> Float {
        return Float.random() * (max - min) + min
    }
}
public extension CGFloat {
    /**
     Returns a random floating point number between 0.0 and 1.0, inclusive.
     By DaRkDOG
     */
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    /**
     Create a random num CGFloat
     :param: min number CGFloat
     :param: max number CGFloat
     :return: random number CGFloat
     By DaRkDOG
     */
    public static func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random() * (max - min) + min
    }
}