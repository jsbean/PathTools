//
//  PowerSequence.swift
//  ArithmeticTools
//
//  Created by James Bean on 3/2/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/// Power-of-two Sequence
internal class PowerSequence<T: ArithmeticType>: Sequence {

    fileprivate let doOvershoot: Bool
    fileprivate let coefficient: T
    fileprivate let max: T
    
    // MARK: - Associated Types
    
    /// PowerGenerator generates ArithmeticType values.
    internal typealias Iterator = PowerGenerator<T>
    
    // MARK: - Initializers
    
    /**
    Create a PowerSequence.
    
    - parameter coefficient: Coefficient that multiplies base of exponential expression
    - parameter max:         Maximum value of generated powers-of-two
    - parameter doOvershoot: If sequence includes the next power-of-two greater than max
    
    - returns: Initialized PowerSequence
    */
    internal init(coefficient: T, max: T, doOvershoot: Bool = false) {
        self.coefficient = coefficient
        self.max = max
        self.doOvershoot = doOvershoot
    }
    
    // MARK: - Instance Methods
    
    /**
    Generate sequence of powers-of-two.
    
    - returns: PowerGenerator
    */
    internal func makeIterator() -> Iterator {
        return PowerGenerator(coefficient: coefficient, max: max, doOvershoot: doOvershoot)
    }
}
