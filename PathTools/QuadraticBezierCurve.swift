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
    
    private struct CoefficientCollection {
        
        typealias Coefficient = (x: Double, y: Double)
        
        let a: Coefficient
        let b: Coefficient
        let c: Coefficient
        
        public init(start: Point, end: Point, controlPoint: Point) {
            self.a = (x: start.x, y: start.y)
            self.b = (x: 2.0 * (controlPoint.x - start.x), y: 2.0 * (controlPoint.y - start.y))
            self.c = (
                start.x - (2.0 * controlPoint.x) + end.x,
                start.y - (2.0 * controlPoint.y) + end.y
            )
        }
    }
    
    private let coefficients: CoefficientCollection
    
    // MARK: - Instance Properties
    
    /// Start.
    public let start: Point
    
    /// End.
    public let end: Point
    
    /// Control point.
    public let controlPoint: Point
    
    // MARK: - Initializers
    
    public init(start: Point, end: Point, controlPoint: Point) {
        self.start = start
        self.end = end
        self.controlPoint = controlPoint
        self.coefficients = CoefficientCollection(
            start: start,
            end: end,
            controlPoint: controlPoint
        )
    }
    
    public func point(t: Double) -> Point {
        return Point(x: x(t: t), y: y(t: t))
    }
    
    // `t` is between `0.0 ... 1.0`
    // TODO: Break out into individual `let`s
    public func x(t: Double) -> Double {
        // (1-t)^2 p0 + 2(1-t) * t * p1 + t^2 * p2
        let (p0,p1,p2) = (start, controlPoint, end)
        return pow(1-t, 2) * p0.x + 2 * (1-t) * t * p1.x + pow(t,2) * p2.x
    }
    
    // `t` is between `0.0 ... 1.0`
    public func y(t: Double) -> Double {
        // (1-t)^2 p0 + 2(1-t) * t * p1 + t^2 * p2
        let (p0,p1,p2) = (start, controlPoint, end)
        return pow(1-t, 2) * p0.y + 2 * (1-t) * t * p1.y + pow(t,2) * p2.y
    }
    
    public func ys(x: Double) -> Set<Double> {
        
        guard contains(x: x) else {
            return []
        }

        let c = coefficients.a.x - x
        let b = coefficients.b.x
        let a = coefficients.c.x
        
        return quadratic(a, b, c)
    }
    
    public func xs(y: Double) -> Double {
        fatalError("Not yet implemented!")
    }
    
    func contains(x: Double) -> Bool {
        let (min, max) = ordered(start.y, end.y)
        return x >= min && x <= max
    }
    
    func contains(y: Double) -> Bool {
        let (min, max) = ordered(start.x, end.x)
        return y >= min && y <= max
    }
    

    
    public func simplified(accuracy: Double) -> [Point] {
        fatalError("Not yet implemented!")
    }
}
