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

extension Axis {
    public static let x: Axis = .horizontal
    public static let y: Axis = .vertical
}

public struct QuadraticBezierCurve: BezierCurveProtocol {
    
    // make protocol for BezierCurveSolver
    private struct Solver: BezierCurveSolver {
        
        /// Coefficients.
        let a,b,c: Point
        
        /// Creates a `QuadraticBezierCurve.Solver` with the given `start`, `end`, and 
        /// `control` points.
        init(start: Point, end: Point, control: Point) {
            self.c = start
            self.b = 2 * (control - start)
            self.a = start - 2 * control + end
        }
        
        /// Possible to return a richer value?
        func ts(for value: Double, on axis: Axis) -> Set<Double> {
            return quadratic(a[axis], b[axis], c[axis] - value)
        }
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
    public init(start: Point, control: Point, end: Point) {
        self.start = start
        self.control = control
        self.end = end
        self.solver = Solver(start: start, end: end, control: control)
    }
    
    /// Creates a `QuadraticBezierCurve` with the given `points`.
    ///
    /// - Warning: Will crash if given greater or less than three points!
    /// - TODO: Make `throw` (implement `BezierPathError`)
    ///
    public init(_ points: [Point]) {
        self.start = points[0]
        self.control = points[1]
        self.end = points[3]
        self.solver = Solver(start: start, end: end, control: control)
    }
    
    public func translatedBy(x: Double, y: Double) -> QuadraticBezierCurve {
        return QuadraticBezierCurve(
            start: start.translatedBy(x: x, y: y),
            control: control.translatedBy(x: x, y: y),
            end: end.translatedBy(x: x, y: y)
        )
    }

    /// - Returns: `Point` at the given `t` value.
    public subscript (t: Double) -> Point {
        return (
            start * pow(1-t, 2) +
            control * 2 * (1-t) * t +
            end * pow(t,2)
        )
    }
    
    /// - Returns: The horizontal position for the given `t` value.
    public func x(t: Double) -> Double {
        return self[t][.x]
    }
    
    /// - Returns: The vertical position for the given `t` value.
    public func y(t: Double) -> Double {
        return self[t][.y]
    }
    
    /// - Returns: The vertical positions for the given `x` value.
    public func ys(x: Double) -> Set<Double> {
    
        let xMin = self[t(at: (.min, .horizontal))][.horizontal]
        let xMax = self[t(at: (.max, .horizontal))][.horizontal]

        guard (xMin...xMax).contains(x) else {
            return []
        }
        
        return Set(solver.ts(for: x, on: .horizontal).map { self[$0][.vertical] })
    }
    
    /// - Returns: The horizontal positions for the given `y` value.
    public func xs(y: Double) -> Set<Double> {
        
        let yMin = self[t(at: (.min, .vertical))][.vertical]
        let yMax = self[t(at: (.max, .vertical))][.vertical]
        
        guard (yMin...yMax).contains(y) else {
            return []
        }

        return Set(solver.ts(for: y, on: .vertical).map { self[$0][.horizontal] })
    }
    
    /// - returns: The `t` value at the given `bound`.
    public func t(at bound: Bound) -> Double {
        
        func initialT(for extremum: Extremum, on axis: Axis) -> Double {
            let numerator = start[axis] - 2 * control[axis] + end[axis]
            let denominator = start[axis] - control[axis]
            return abs(denominator) > 0.0000001 ? numerator / denominator : 0
        }
        
        /// - TODO: Refactor
        func tAndCompareValue(start: Double, end: Double, for extremum: Extremum)
            -> (t: Double, value: Double)
        {
            let compare: (Double, Double) -> Bool = extremum == .min ? (<) : (>)
            return compare(end, start) ? (t: 1, value: end) : (t: 0, value: start)
        }
        
        /// - TODO: Refactor
        func isValid(t: Double, given value: Double, on axis: Axis, for extremum: Extremum)
            -> Bool
        {
            let compare: (Double, Double) -> Bool = extremum == .min ? (<) : (>)
            return compare(self[t][axis], value)
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

extension QuadraticBezierCurve: Equatable {
    
    public static func == (lhs: QuadraticBezierCurve, rhs: QuadraticBezierCurve) -> Bool {
        return (
            lhs.start == rhs.start &&
            lhs.control == rhs.control &&
            lhs.end == rhs.end
        )
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
