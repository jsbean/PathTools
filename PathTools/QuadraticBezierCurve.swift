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

public enum Extremum {
    case max
    case min
}

public enum Axis {
    case vertical, horizontal
}

public struct QuadraticBezierCurve: BezierCurve {
    
    
    
    public typealias Bound = (extremum: Extremum, axis: Axis)

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
    
    private func position(for axis: Axis) -> (Point) -> Double {
        return axis == .horizontal ? { $0.x } : { $0.y }
    }
    
    private let solver: Solver
    
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
    
        let xMin = point(t: t(at: (.min, .horizontal))).x
        let xMax = point(t: t(at: (.max, .horizontal))).x

        guard (xMin...xMax).contains(x) else {
            return []
        }
        
        let ts = solver.ts(x: x)
        return Set(ts.map(point).map { $0.y })
    }
    
    /// - Returns: The horizontal positions for the given `y` value.
    public func xs(y: Double) -> Set<Double> {
        
        let yMin = point(t: t(at: (.min, .vertical))).y
        let yMax = point(t: t(at: (.max, .vertical))).y
        
        guard (yMin...yMax).contains(y) else {
            return []
        }
        
        let ts = solver.ts(y: y)
        return Set(ts.map(point).map { $0.x })
    }
    
    /// - returns: The `t` value at the given `bound`.
    public  func t(at bound: Bound) -> Double {
        
        func initialT(for extremum: Extremum, on axis: Axis) -> Double {
            let numerator = start[axis] - 2 * control[axis] + end[axis]
            let denominator = start[axis] - control[axis]
            return abs(denominator) > 0.0000001 ? numerator / denominator : 0
        }
        
        func tAndCompareValue(start: Double, end: Double, for extremum: Extremum)
            -> (t: Double, value: Double)
        {
            let compare: (Double, Double) -> Bool = extremum == .min ? (<) : (>)
            return compare(end, start) ? (t: 1, value: end) : (t: 0, value: start)
        }
        
        func isValid(t: Double, given value: Double, on axis: Axis, for extremum: Extremum)
            -> Bool
        {
            let compare: (Double, Double) -> Bool = extremum == .min ? (<) : (>)
            return compare(point(t: t)[axis], value)
        }
        
        let (extremum, axis) = bound
        let initT = initialT(for: extremum, on: axis)        
        let (t, compareVal) = tAndCompareValue(start: start[axis], end: end[axis], for: extremum)
        let valid = isValid(t: initT, given: compareVal, on: axis, for: extremum)
        return (initT > 0 && initT < 1) && valid ? initT : t
    }

    public func simplified(accuracy: Double) -> [Point] {
        fatalError("Not yet implemented!")
    }
}

/// Move up to `dn-m/GeometryTools`.
extension Point {
    public subscript (axis: Axis) -> Double {
        return axis == .horizontal ? x : y
    }
}

/// - returns: A `Set` of 0, 1, or 2 x-intercepts for the given coefficients.
///
/// - TODO: Update in dn-m/ArithmeticTools
public func quadratic(_ a: Double, _ b: Double, _ c: Double) -> Set<Double> {
    
    let discriminant = pow(b,2) - (4 * a * c)
    
    guard discriminant >= 0 else {
        return Set()
    }
    
    let val0 = (-b + sqrt(discriminant)) / (2 * a)
    let val1 = (-b - sqrt(discriminant)) / (2 * a)
    
    var result: Set<Double> = []
    
    // This differs from the more generic version. Find a way to do this cleansing after?
    if val0 <= 1 {
        result.insert(val0)
    }
    
    if (0...1).contains(val1) {
        result.insert(val1)
    }
    
    return result
}
