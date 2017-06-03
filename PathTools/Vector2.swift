//
//  Vector2.swift
//  PathTools
//
//  Created by James Bean on 6/3/17.
//
//

import Darwin

/// Two-dimensional Vector
///
/// - TODO: Move to dn-m/ArithmeticTools
///
public struct Vector2 {
    
    // MARK: - Instance Properties
    
    /// Length of a `Vector2`
    var length: Double {
        return hypot(x,y)
    }
    
    /// X value.
    let x: Double
    
    /// Y value.
    let y: Double
    
    // MARK: - Initializers
    
    /// Creates a `Vector2` with the given `x` and `y` values.
    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}
