//
//  Functions.swift
//  ArithmeticTools
//
//  Created by James Bean on 2/16/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/**
 Get the greatest common divisor of two values.
 
 >`greatestCommonDivisor(12,16) -> 4`
 
 - parameter a: ArithmeticType value
 - parameter b: ArithmeticType value
 
 - returns: Greatest common divisor of a and b
 */
public func greatestCommonDivisor<T: ArithmeticType>(_ a: T, _ b: T) -> T {
    let result = T.mod(a,b)
    return result == T.zero ? b : greatestCommonDivisor(b, result)
}

/**
 Get the closer of two values to a target value.
 
 >`closer(to: 11, a: 12, b: 3) -> 12`
 
 - note: If the distances between both values and the target value are equivalent, the first
 value (a) is returned.
 
 >`closer(to: 6, a: 4, b: 8) -> 4`

 - returns: Value closer to target value
 */
public func closer<T: ArithmeticType>(to target: T, a: T, b: T) -> T {
    return T.abs(a - target) <= T.abs(b - target) ? a : b
}

/**
 - note: If both values are equal, they are returned in the order in which they were given
 
 - returns: 2-tuple of two `Comparable` types, in order.
 */
public func ordered<T: Comparable>(_ a: T, _ b: T) -> (T,T) {
    return a <= b ? (a,b) : (b,a)
}

// FIXME: Add doc comment
public func mean<T: ArithmeticType>(_ a: T, _ b: T) -> T {
    return (a + b) / T.two
}
