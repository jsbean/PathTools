//
//  PowerGenerator.swift
//  ArithmeticTools
//
//  Created by James Bean on 3/2/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


/// Power-of-two Generator
internal class PowerGenerator<T: ArithmeticType>: IteratorProtocol {
    
    // MARK: - Associated Types
    
    /// This GeneratorType generates ArithmeticType values
    internal typealias Element = T
    
    fileprivate let doOvershoot: Bool
    fileprivate var hasOvershot: Bool = false
    
    fileprivate var power: T
    fileprivate var coefficient: T
    fileprivate var max: T?
    
    // MARK: - Initializers
    
    /**
     Create a PowerGenerator.
     
     - parameter coefficient: Coefficient that multiplies base of exponential expression
     - parameter max:         Maximum value of generated powers-of-two
     - parameter doOvershoot: If generator includes the next power-of-two greater than max
     
     - returns: Initialized PowerGenerator
     */
    internal init(coefficient: T, max: T? = nil, doOvershoot: Bool = false) {
        self.power = coefficient
        self.coefficient = coefficient
        self.max = max
        self.doOvershoot = doOvershoot
    }
    
    // MARK: - Instance Methods

    /// Advance to the next element and return it, or nil if no next element exists.
    internal func next() -> Element? {
        if doOvershoot {
            if hasOvershot { return nil }
            if power > max {
                hasOvershot = true
                return power
            }
        }
        let result = power
        power = power * T.two
        if let max = max { return result <= max ? result : nil }
        return result
    }
}
