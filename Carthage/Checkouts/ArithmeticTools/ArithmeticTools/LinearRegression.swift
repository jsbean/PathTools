//
//  LinearRegression.swift
//  ArithmeticTools
//
//  Created by James Bean on 11/8/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/// - returns: All given values risen to the power of two.
public func squared <A: ArithmeticType> (_ values: [A]) -> [A] {
    return values.map { $0 * $0 }
}

/// - returns: All values of `lhs` multiplied by the corresponding value in `rhs`.
public func * <A: ArithmeticType> (lhs: [A], rhs: [A]) -> [A] {
    return zip(lhs, rhs).map(*)
}

/// - returns: Slope of linear regression of given x-values and y-values.
public func slope <A: ArithmeticType> (_ xs: [A], _ ys: [A]) -> Float {
    let sum1 = (xs * ys).mean! - (xs.mean! * ys.mean!)
    let sum2 = squared(xs).mean! - pow(xs.mean!, 2)
    return sum1 / sum2
}

/// - returns: Function that will calculate the y-value for the given x-value on the 
///     regression.
///
/// - note: Modified from: [Ray Wenderlich Swift Algorithm Club](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Linear%20Regression)
public func linearRegression <A: ArithmeticType> (_ xs: [A], _ ys: [A]) -> (Float) -> (Float) {
    
    guard !(xs.isEmpty || ys.isEmpty) else { return { _ in 0 } }
    
    let m = slope(xs,ys)
    let intercept = ys.mean! - (m * xs.mean!)
    
    return { x in m * x + intercept }
}

/// - returns: Slope of the linear regression.
public func slope <A: ArithmeticType> (_ dictionary: [A: A]) -> Float {
    return slope(Array(dictionary.keys), Array(dictionary.values))
}

/// - returns: Function that will calculate the y-value for the given x-value on the regression.
public func linearRegression <A: ArithmeticType> (_ dictionary: [A: A]) -> (Float) -> Float {
    return linearRegression(Array(dictionary.keys), Array(dictionary.values))
}
