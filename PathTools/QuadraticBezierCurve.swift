//
//  QuadraticBezierCurve.swift
//  PathTools
//
//  Created by James Bean on 11/24/16.
//
//

import Darwin
import ArithmeticTools
import GeometryTools

public struct QuadraticBezierCurve: BezierCurve {
    
    private struct Solver {
        
        typealias Coefficient = (x: Double, y: Double)
        
        let a: Coefficient
        let b: Coefficient
        let c: Coefficient
        
        fileprivate init(start: Point, end: Point, controlPoint: Point) {
            
            self.a = (
                x: start.x - 2 * controlPoint.x + end.x,
                y: start.y - 2 * controlPoint.y + end.y
            )
            
            self.b = (
                x: 2 * (controlPoint.x - start.x),
                y: 2 * (controlPoint.y - start.y)
            )
            
            self.c = (
                x: start.x,
                y: start.y
            )
        }

        func ts(x: Double) -> Set<Double> {
            return quadratic(a.x, b.x, c.x - x)
        }
        
        func ts(y: Double) -> Set<Double> {
            return quadratic(a.y, b.y, c.y - y)
        }

        func xs(y: Double) -> Set<Double> {
            return quadratic(a.y, b.y, c.y - y)
        }
        
        func ys(x: Double) -> Set<Double> {
            return quadratic(a.x, b.x, c.x - x)
        }
    }
    
    private let solver: Solver
    
    /// - Returns: The `t` value at the point of the minimum `x` value.
    public var tAtMinX: Double {
        
        let denominator = start.x - 2 * control.x + end.x
        var initialT: Double = 0
        
        if abs(denominator) > 0.0000001 {
            initialT = (start.x - control.x) / denominator
        }
        
        var t: Double = 0
        var minX = start.x
        
        if end.x < minX {
            t = 1
            minX = end.x
        }
        
        if initialT > 0 && initialT < 1 {
            if point(t: initialT).x < minX {
                t = initialT
            }
        }
        
        return t
    }
    
    /// - Returns: The `t` value at the point of the maximum `x` value.
    public var tAtMaxX: Double {
        
        let denominator = start.x - 2 * control.x + end.x
        var initialT: Double = 0
        
        if abs(denominator) > 0.0000001 {
            initialT = (start.x - control.x) / denominator
        }
        
        var t: Double = 0
        var maxX = start.x
        
        if end.x > maxX {
            t = 1
            maxX = end.x
        }
        
        if initialT > 0 && initialT < 1 {
            if point(t: initialT).x > maxX {
                t = initialT
            }
        }
        
        return t
    }
    
    /// - Returns: The `t` value at the point of the minimum `y` value.
    public var tAtMinY: Double {
        
        let denominator = start.y - 2 * control.y + end.y
        var initialT: Double = 0
        if abs(denominator) > 0.0000001 {
            initialT = (start.y - control.y) / denominator
        }
        
        var t: Double = 0
        var minY = start.y
        
        if end.y < minY {
            t = 1
            minY = end.y
        }
        
        if initialT > 0 && initialT < 1 {
            if point(t: initialT).y < minY {
                t = initialT
            }
        }
        
        return t
    }
    
    /// - Returns: The `t` value at the point of the maximum `y` value.
    public var tAtMaxY: Double {
        
        let denominator = start.y - 2 * control.y + end.y
        var initialT: Double = 0
        
        if abs(denominator) > 0.0000001 {
            initialT = (start.y - control.y) / denominator
        }
        
        var t: Double = 0
        var maxY = start.y
        
        if end.y > maxY {
            t = 1
            maxY = end.y
        }
        
        if initialT > 0 && initialT < 1 {
            if point(t: initialT).y > maxY {
                t = initialT
            }
        }
        
        return t
    }
    
    // MARK: - Instance Properties
    
    /// Start.
    public let start: Point
    
    /// End.
    public let end: Point
    
    /// Control point.
    public let control: Point
    
    // MARK: - Initializers
    
    /// Creates a `QuadraticBezierCurve` with the given `start`, `end`, and `control` points.
    public init(start: Point, end: Point, control: Point) {
        self.start = start
        self.end = end
        self.control = control
        self.solver = Solver(
            start: start,
            end: end,
            controlPoint: control
        )
    }
    
    /// - Returns: `Point` at the given `t` value.
    public func point(t: Double) -> Point {
        return Point(x: x(t: t), y: y(t: t))
    }
    
    /// - Returns: The horizontal position for the given `t` value.
    public func x(t: Double) -> Double {
        // (1-t)^2 p0 + 2(1-t) * t * p1 + t^2 * p2
        let (p0,p1,p2) = (start, control, end)
        return pow(1-t, 2) * p0.x + 2 * (1-t) * t * p1.x + pow(t,2) * p2.x
    }
    
    /// - Returns: The vertical position for the given `t` value.
    public func y(t: Double) -> Double {
        // (1-t)^2 p0 + 2(1-t) * t * p1 + t^2 * p2
        let (p0,p1,p2) = (start, control, end)
        return pow(1-t, 2) * p0.y + 2 * (1-t) * t * p1.y + pow(t,2) * p2.y
    }
    
    /// - Returns: The vertical positions for the given `x` value.
    public func ys(x: Double) -> Set<Double> {
    
        let xMin = point(t: tAtMinX).x
        let xMax = point(t: tAtMaxX).x

        guard (xMin...xMax).contains(x) else {
            return []
        }
        
        let ts = solver.ts(x: x)
        return Set(ts.map(point).map { $0.y })
    }
    
    /// - Returns: The horizontal positions for the given `y` value.
    public func xs(y: Double) -> Set<Double> {
        
        let yMin = point(t: tAtMinY).y
        let yMax = point(t: tAtMaxY).y
        
        guard (yMin...yMax).contains(y) else {
            return []
        }
        
        let ts = solver.ts(y: y)
        return Set(ts.map(point).map { $0.x })
    }

    public func simplified(accuracy: Double) -> [Point] {
        fatalError("Not yet implemented!")
    }
}

/// - returns: A `Set` of 0, 1, or 2 x-intercepts for the given coefficients.
///
/// - TODO: Update in dn-m/ArithmeticTools
public func quadratic (_ a: Double, _ b: Double, _ c: Double) -> Set<Double> {
    
    let discriminant = pow(b,2) - (4 * a * c)
    
    guard discriminant >= 0 else {
        return Set()
    }
    
    let val0 = (-b + sqrt(discriminant)) / (2 * a)
    let val1 = (-b - sqrt(discriminant)) / (2 * a)
    
    var result: Set<Double> = []
    
    if val0 <= 1 {
        result.insert(val0)
    }
    
    if (0...1).contains(val1) {
        result.insert(val1)
    }
    
    return result
}
