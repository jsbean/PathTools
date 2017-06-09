//
//  CubicBezierCurve.swift
//  PathTools
//
//  Created by James Bean on 11/24/16.
//
//

import Darwin
import GeometryTools

/// Model of a cubic bezier curve.
public struct CubicBezierCurve: BezierCurve {

    private struct Solver {
        
        /// Coefficients.
        let a,b,c,d: Point
        
        public init(start: Point, end: Point, control1: Point, control2: Point) {
            self.d = start
            self.c = 3 * (control1 - start)
            self.b = 3 * (control2 - control1) - c
            self.a = end - start - c - b
        }
    }
    
    private let solver: Solver
    
    /// Start point.
    public let start: Point
    
    /// End point.
    public let end: Point
    
    /// First control point.
    public let control1: Point
    
    /// Second control point.
    public let control2: Point
    
    // MARK: - Initializers
    
    /// Creates a `CubicBezierCurve` with the given `start`, `end`, and control points.
    public init(start: Point, end: Point, control1: Point, control2: Point) {
        self.start = start
        self.end = end
        self.control1 = control1
        self.control2 = control2
        self.solver = Solver(start: start, end: end, control1: control1, control2: control2)
    }
    
    public subscript (t: Double) -> Point {
        // B(t) = (1-t)**3 p0 + 3(1 - t)**2 t P1 + 3(1-t)t**2 P2 + t**3 P3
        return (
            start * pow(1-t, 3) +
            control1 * 3 * pow(1-t, 2) * t +
            control1 * 3 * (1-t) * pow(t,2) +
            end * pow(t,3)
        )
    }
    
    public func x(t: Double) -> Double {
        return self[t][.horizontal]
    }
    
    public func y(t: Double) -> Double {
        return self[t][.vertical]
    }
    
    public func ys(x: Double) -> Set<Double> {
        fatalError()
    }
    
    public func xs(y: Double) -> Set<Double> {
        fatalError("Not yet implemented!")
    }
    
    public func simplified(accuracy: Double) -> [Point] {
        fatalError("Not yet implemented!")
    }
}


// Port of degrafa
//public class BezierCurveCubic: BezierCurve {
//    
//    public func simplified(accuracy: Double) -> [Point] {
//        fatalError()
//    }
//
//    /// - returns: The x-value for a given `y`.
//    public func x(y: Double) -> Double {
//        fatalError()
//    }
//
//    /// - returns: All y-values for a given `x`.
//    public func ys(x: Double) -> Set<Double> {
//        fatalError()
//    }
//    
//    // Start point
//    public var start: Point
//    
//    // End point
//    public var end: Point
//    
//    // First control point
//    public var controlPoint1: Point
//    
//    // Second control point
//    public var controlPoint2: Point
//    
//    
//    // Coefficients
//    private var c0x: Double = 0
//    private var c0y: Double = 0
//    private var c1x: Double = 0
//    private var c1y: Double = 0
//    private var c2x: Double = 0
//    private var c2y: Double = 0
//    private var c3x: Double = 0
//    private var c3y: Double = 0
//    
//    // Limit on interval width before interval is considered completely bisected
//    private var bisectLimit: Double = 0.05
//    
//    // Bisection interval bounds
//    private var bisectLeft: Double = 0
//    private var bisectRight: Double = 0
//    
//    // Stationary points of x(t) and y(t) ?!?!?!?!?!
//    private var t1x: Double = 0
//    private var t1y: Double = 0
//    private var t2x: Double = 0
//    private var t2y: Double = 0
//    
//    private var twbrf: Int? = nil // TO BE SimpleRoot
//    private var solver2x2: Int? = nil // TO BE Solve2x2
//    
//    public init(point1: Point, controlPoint1: Point, controlPoint2: Point, point2: Point) {
//        self.start = point1
//        self.end = point2
//        self.controlPoint1 = controlPoint1
//        self.controlPoint2 = controlPoint2
//        setCoefficients()
//    }
//    
//    
//    // P(t) = (1 - t)^3 * P0 + 3t(1-t)^2 * P1 + 3t^2 (1-t) * P2 + t^3 * P3
//    
//    // Tangent (derivative):
//    // dP(t) / dt =  -3(1-t)^2 * P0 + 3(1-t)^2 * P1 - 6t(1-t) * P1 - 3t^2 * P2 + 6t(1-t) * P2 + 3t^2 * P3
//    
//    // test?
//    public func getPointAtT(t: Double) -> Point? {
//        if t < 0 || t > 1 { return nil }
//        let x: Double = c0x + t * (c1x + t * (c2x + t * c3x))
//        let y: Double = c0y + t * (c1y + t * (c2y + t * c3y))
//        return Point(x: x, y: y)
//    }
//    
//    public func getYValuesAtX(x: Double) -> [Double] {
//        
//        // check x is in bounds -- TODO: change isWithinBounds to use tAtMinX, tAtMinY, etc...
//        if !isWithinBounds(x: x) { return [] }
//        
//        // Find a root, then factor out (t-r) to get a quadratic poly for the remaining roots
//        func f(t: Double) -> Double {
//            let val = t * (c1x + t * (c2x + t * c3x)) + c0x - x
//            return val
//        }
//        
//        // Instantiate The World's Best Root Finder
//        let twbrf = SimpleRoot()
//        
//        // Some cubic curves need to be bisected in case of curling around themselves
//        bisectLeft = 0
//        bisectRight = 1
//        bisect(left: 0, right: 1, f: f)
//        
//        let t0: Double = twbrf.findRoot(
//            x0: bisectLeft,
//            x2: bisectRight,
//            maximumIterationLimit: 50,
//            tolerance: 0.000001,
//            f: f
//        )
//        
//        // is this required?
//        /*
//         let eval = abs(f(t0))
//         if eval > 0.00001 {
//         print("eval > 0.00001; return [] ?!?!?!?")
//         return []
//         }
//         */
//        
//        // this will contain 0 to 3 y values for specified x value
//        var result: [Double] = []
//        
//        // Add first point if present
//        if t0 <= 1 { if let y = getPointAtT(t: t0)?.y { result.append(y) } }
//        
//        // Continue to check for remaining two points
//        var a = c3x
//        let b = (t0 * a) + c2x
//        let c = (t0 * b) + c1x
//        var d = (b * b) - (4 * a * c)
//        
//        // Can't do sqrt of negative number, get out of here
//        if d < 0 { return result }
//        
//        // Otherwise, continue
//        d = sqrt(d)
//        a = 1 / (a + a)
//        let t1 = (d - b) * a
//        let t2 = (-b - d) * a
//        
//        // Add second point if present
//        if t1 >= 0 && t1 <= 1 { if let y = getPointAtT(t: t1)?.y { result.append(y) } }
//        
//        // Add third point if present
//        if t2 >= 0 && t2 <= 1 { if let y = getPointAtT(t: t2)?.y { result.append(y) } }
//        
//        return result
//    }
//    
//    public func bisect(left l: Double, right r: Double, f: (Double) -> Double) {
//        
//        if abs(r - l) <= bisectLimit { return }
//        
//        // perhaps not necessary
//        let left = l
//        let right = r
//        
//        let middle = 0.5 * (left + right)
//        if f(left) * f(right) <= 0 {
//            bisectLeft = left
//            bisectRight = right
//            return
//        }
//        else {
//            bisect(left: left, right: middle, f: f)
//            bisect(left: middle, right: right, f: f)
//        }
//    }
//    
//    public func getXAtY(y: Double) -> [Double] {
//        // TODO
//        return []
//    }
//    
//    public func getTAtMaxX() -> Double {
//        // TODO
//        return 0
//    }
//    
//    public func getTAtMinX() -> Double {
//        // TODO
//        return 0
//    }
//    
//    public func getTAtMinY() -> Double {
//        // TODO
//        return 0
//    }
//    
//    public func getTAtMaxY() -> Double {
//        // TODO
//        return 0
//    }
//    
//    
//    private func setCoefficients() {
//        c0x = start.x
//        c0y = start.y
//        c1x = 3 * (controlPoint1.x - start.x)
//        c1y = 3 * (controlPoint1.y - start.y)
//        c2x = 3 * (controlPoint2.x - controlPoint1.x) - c1x
//        c2y = 3 * (controlPoint2.y - controlPoint1.y) - c1y
//        c3x = end.x - start.x - c2x - c1x
//        c3y = end.y - start.y - c2y - c1y
//    }
//}

// SimpleRoot.swift - As straight a port as I could get my head around of Jim Armstrong's
// port of Jack Crenshaw's TWBRF simple root finding algorithm. See license below:
//
// SimpleRoot.as - A straight port of Jack Crenshaw's TWBRF method for simple roots in an interval.
// -- To use, identify an interval in which the function whose zero is desired has a sign change
// -- (via bisection, for example).  Call the findRoot method.
//
// This program is derived from source bearing the following copyright notice,
//
// Copyright (c) 2008, Jim Armstrong.  All rights reserved.
//
// This software program is supplied 'as is' without any warranty, express,
// implied, or otherwise, including without limitation all warranties of
// merchantability or fitness for a particular purpose.  Jim Armstrong shall not
// be liable for any special incidental, or consequential damages, including,
// witout limitation, lost revenues, lost profits, or loss of prospective
// economic advantage, resulting from the use or misuse of this software program.
//
// Programmed by Jim Armstrong, (http://algorithmist.wordpress.com)
// Ported to Degrafa with full permission of author
/**
 * @version 1.0
 */

public class SimpleRoot {
    
    private var i: Int = 0
    
    public init() { }
    
    public func findRoot(
        x0: Double,
        x2: Double,
        maximumIterationLimit: Int,
        tolerance: Double,
        f: (Double) -> Double
    ) -> Double
    {
        var xmLast: Double = x0
        var y0: Double = f(x0)
        if y0 == 0.0 { return x0 }
        
        var y2 = f(x2)
        if y2 == 0.0 { return x2 }
        if y2 * y0 > 0.0 { return x0 }
        
        var x0 = x0
        var x2 = x2
        var x1: Double = 0
        var y1: Double = 0
        var xm: Double = 0
        var ym: Double = 0
        
        while i <= maximumIterationLimit {
            
            // increment
            i += 1
            
            x1 = 0.5 * (x2 + x0)
            y1 = f(x1)
            if y1 == 0 { return x1 }
            
            if abs(x1 - x0) < tolerance { return x1 }
            
            if y1 * y0 > 0 {
                var temp = x0
                x0 = x2
                x2 = temp
                temp = y0
                y0 = y2
                y2 = temp
            }
            
            let y10 = y1 - y0
            let y21 = y2 - y1
            let y20 = y2 - y0
            
            if (y2 * y20 < 2 * y1 * y0) {
                x2 = x1
                y2 = y1
            }
            else {
                let b = (x1 - x0) / y10
                let c = (y10 - y21) / (y21 * y20)
                xm = x0 - b * y0 * (1 - c * y1)
                ym = f(xm)
                if ym == 0 { return xm }
                if abs(xm - xmLast) < tolerance { return xm }
                xmLast = xm
                if ym * y0 < 0 {
                    x2 = xm
                    y2 = ym
                }
                else {
                    x0 = xm
                    y0 = ym
                    x2 = x1
                    y2 = y1
                }
            }
        }
        return x1
    }
}
