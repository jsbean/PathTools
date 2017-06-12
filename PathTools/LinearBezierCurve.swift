//
//  LinearBezierCurve.swift
//  PathTools
//
//  Created by James Bean on 11/24/16.
//
//

import Darwin
import GeometryTools

// Model of a linear bezier curve.
public struct LinearBezierCurve: BezierCurve {
    
    // MARK: - Instance Properties
    
    /// Start point.
    public let start: Point
    
    /// End point.
    public let end: Point
    
    // MARK: - Initializers
    
    /// Creats a `LinearBezierCurve` with the given `start` and `end` points.
    public init(start: Point, end: Point) {
        self.start = start
        self.end = end
    }
    
    // MARK: - Subscripts
    
    /// - Returns: `Point` at the given `t` value.
    public subscript (t: Double) -> Point {
        return t * (end - start) + start
    }
    
    // MARK: - Instance Properties

    /// - Returns: The vertical position for the given `x` value.
    public func ys(x: Double) -> Set<Double> {
        return [start.y + ((x - start.x) / (end.x - start.x)) * (end.y - start.y)]
    }
    
    /// - Returns: The horizontal position for the given `y` value.
    public func xs(y: Double) -> Set<Double> {
        return [start.x + ((y - start.y) / (end.y - start.y)) * (end.x - start.x)]
    }
    
    public func simplified(accuracy: Double) -> [Point] {
        fatalError("Not yet implemented!")
    }
}
