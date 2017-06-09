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
    
    public enum Extremum {
        case max
        case min
    }
    
    public enum Axis {
        case vertical, horizontal
    }
    
    public typealias Bound = (Extremum, Axis)

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
    
    

    private func initialT(on axis: Axis) -> Double {
        
        func denominator(on axis: Axis) -> Double {
            switch axis {
            case .horizontal:
                return start.x - 2 * control.x + end.x
            case .vertical:
                return start.y - 2 * control.y + end.y
            }
        }
        
        func numerator(on axis: Axis) -> Double {
            switch axis {
            case .horizontal:
                return start.x - control.x
            case .vertical:
                return start.y - control.y
            }
        }
        
        let n = numerator(on: axis)
        let d = denominator(on: axis)
        return abs(d) > 0.0000001 ? n / d : 0
    }
    
//    private func initialValue(on axis: Axis) -> Double {
//        switch axis {
//        case .horizontal:
//            return start.x
//        case .vertical:
//            return start.y
//        }
//    }
    
    private func startValue(on axis: Axis) -> Double {
        switch axis {
        case .horizontal:
            return start.x
        case .vertical:
            return start.y
        }
    }
    
    private func endValue(on axis: Axis) -> Double {
        switch axis {
        case .horizontal:
            return start.x
        case .vertical:
            return start.y
        }
    }
    
    func tAndPotentialValue(start: Double, end: Double, compare: (Double, Double) -> Bool)
        -> (t: Double, value: Double)
    {
        return compare(end,start) ? (t: 1, value: end) : (t: 0, value: start)
    }
    
    /// - Returns: The `t` value at the point of the minimum `x` value.
    private var tAtMinX: Double {

        let initT = initialT(on: .horizontal)
        let startVal = startValue(on: .horizontal)
        let endVal = endValue(on: .horizontal)
        let (t, potentialVal) = tAndPotentialValue(start: startVal, end: endVal, compare: <)
        
        // if init is in (0,1) && x[t] < initialValue: return initialT
        // otherwise, return 1/0
        if initT > 0 && initT < 1 && point(t: initT).x < potentialVal {
            return initT
        }
        
        // Either returns:
        // - 0: initialValue >= end.x, initT is NOT in (0,1), t[x] >= initialVlue
        // - 1: initialValue >= end.x, initT is NOT in (0,1)
        // - other:

        
        return t
    }
    
    /// - Returns: The `t` value at the point of the maximum `x` value.
    private var tAtMaxX: Double {
        
        let initT = initialT(on: .horizontal)
        var maxX = startValue(on: .horizontal)
        var t: Double = 0
        
        if end.x > maxX {
            t = 1
            maxX = end.x
        }
        
        if initT > 0 && initT < 1 {
            if point(t: initT).x > maxX {
                t = initT
            }
        }
        
        return t
    }
    
    /// - Returns: The `t` value at the point of the minimum `y` value.
    private var tAtMinY: Double {
       
        let initT = initialT(on: .vertical)
        
        
        var minY = startValue(on: .vertical)
        var t: Double = 0
        
        
        
        if end.y < minY {
            t = 1
            minY = end.y
        }
        
        if initT > 0 && initT < 1 {
            if point(t: initT).y < minY {
                t = initT
            }
        }
        
        return t
    }
    
    /// - Returns: The `t` value at the point of the maximum `y` value.
    private var tAtMaxY: Double {
        
        let initT = initialT(on: .vertical)
        
        var t: Double = 0
        var maxY = startValue(on: .vertical)
        
        if end.y > maxY {
            t = 1
            maxY = end.y
        }
        
        if initT > 0 && initT < 1 {
            if point(t: initT).y > maxY {
                t = initT
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
    
    /// - returns: The `t` value at the given `bound`.
    public  func t(at bound: Bound) -> Double {
        switch bound {
        case (.min, .horizontal):
            return tAtMinX
        case (.max, .horizontal):
            return tAtMaxX
        case (.min, .vertical):
            return tAtMinY
        case (.max, .vertical):
            return tAtMaxY
        }
    }

    public func simplified(accuracy: Double) -> [Point] {
        fatalError("Not yet implemented!")
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
