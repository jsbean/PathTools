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
    
    func x(t: Double) -> Double
    
    func y(t: Double) -> Double
    
    /// - returns: All y-values for a given `x`.
    func ys(x: Double) -> Set<Double>
    
    /// - returns: The x-value for a given `y`.
    func xs(y: Double) -> Set<Double>
    
    func simplified(accuracy: Double) -> [Point]
}
