//
//  Quadratic.swift
//  PathTools
//
//  Created by James Bean on 11/24/16.
//
//

import QuartzCore

// TODO: Move to `ArithmeticType`.

/// - returns: Two possible answers, if `descriminant > 0`. Returns an empty set if the 
///     discriminant is empty, and the solution would therefore be complex.
public func quadratic(_ a: CGFloat, _ b: CGFloat, _ c: CGFloat) -> Set<CGFloat> {
    
    let discriminant = pow(b,2) - 4 * a * c
    
    guard discriminant > 0 else {
        return Set()
    }

    return Set(
        [1, -1].map { sign in (-b + sign * sqrt(discriminant)) / (2 * a) }
    )
}
