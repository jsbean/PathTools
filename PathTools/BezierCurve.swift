//
//  BezierCurve.swift
//  PathTools
//
//  Created by James Bean on 11/24/16.
//
//

import GeometryTools

public protocol BezierCurveProtocol: Equatable {
 
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
    
    func translatedBy(x: Double, y: Double) -> Self

    func simplified(accuracy: Double) -> [Point]
}

public enum BezierCurve {
    
    /// Start point of Bézier curve.
    var start: Point {
        switch self {
        case let .linear(linear):
            return linear.start
        case let .quadratic(quad):
            return quad.start
        case let .cubic(cubic):
            return cubic.start
        }
    }
    
    /// End point of Bézier curve.
    var end: Point {
        switch self {
        case let .linear(linear):
            return linear.end
        case let .quadratic(quadratic):
            return quadratic.end
        case let .cubic(cubic):
            return cubic.end
        }
    }
    
    case linear(LinearBezierCurve)
    case quadratic(QuadraticBezierCurve)
    case cubic(CubicBezierCurve)
    
    public func translatedBy(x: Double, y: Double) -> BezierCurve {
        switch self {
        case let .linear(linear):
            return .linear(linear.translatedBy(x: x, y: y))
        case let .quadratic(quadratic):
            return .quadratic(quadratic.translatedBy(x: x, y: y))
        case let .cubic(cubic):
            return .cubic(cubic.translatedBy(x: x, y: y))
        }
    }
}

extension BezierCurve: Equatable {
    public static func == (lhs: BezierCurve, rhs: BezierCurve) -> Bool {
        switch (lhs, rhs) {
        case let (.linear(a), .linear(b)):
            return a == b
        case let (.quadratic(a), .quadratic(b)):
            return a == b
        case let (.cubic(a), .cubic(b)):
            return a == b
        default:
            return false
        }
    }
}
