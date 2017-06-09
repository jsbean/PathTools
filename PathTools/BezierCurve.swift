//
//  BezierCurve.swift
//  PathTools
//
//  Created by James Bean on 11/24/16.
//
//

import GeometryTools

public protocol BezierCurve {
 
    /// Start point of Bézier curve.
    var start: Point { get }
    
    /// End point of Bézier curve.
    var end: Point { get }

    /// - Returns: The point at the given `t` value.
    ///
    /// - Note: Values contained within the curve itself are index by `t` values in [0,1].
    /// If `t` values of less than 0 or greater than 1 will project the curve beyond its
    /// `start` and `end` points.
    ///
    subscript (t: Double) -> Point { get }

    /// - returns: All y-values for a given `x`.
    func ys(x: Double) -> Set<Double>
    
    /// - returns: The x-value for a given `y`.
    func xs(y: Double) -> Set<Double>

    func simplified(accuracy: Double) -> [Point]
}
