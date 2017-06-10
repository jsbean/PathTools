//
//  CubicBezierCurve.swift
//  PathTools
//
//  Created by James Bean on 11/24/16.
//
//

import Darwin
import GeometryTools

/// - TODO: Move to `dn-m/GeometryTools`
extension Line {
    
    public static func horizontal(at y: Double) -> Line {
        return Line(
            start: Point(x: .leastNormalMagnitude, y: y),
            end: Point(x: .greatestFiniteMagnitude, y: y)
        )
    }
    
    public static func vertical(at x: Double) -> Line {
        return Line(
            start: Point(x: x, y: .leastNormalMagnitude),
            end: Point(x: x, y: .greatestFiniteMagnitude)
        )
    }
}

/// Model of a cubic bezier curve.
public struct CubicBezierCurve: BezierCurve {

    
    internal final class Solver: BezierCurveSolver {
        
        /// Coefficients.
        let a,b,c,d: Point
        
        internal init(start: Point, end: Point, control1: Point, control2: Point) {
            self.d = start
            self.c = 3 * (control1 - start)
            self.b = 3 * (control2 - control1) - c
            self.a = end - start - c - b
        }
        
        func ts(for value: Double, on axis: Axis) -> Set<Double> {
            fatalError()
        }
    }
    
    internal let solver: Solver
    
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
            control2 * 3 * (1-t) * pow(t,2) +
            end * pow(t,3)
        )
    }
    
    public func x(t: Double) -> Double {
        return self[t][.horizontal]
    }
    
    public func y(t: Double) -> Double {
        return self[t][.vertical]
    }
    
    public func t(at bound: Bound) -> Double {
        fatalError()
    }
    
    public func ys(x: Double) -> Set<Double> {
        let ts = cardano(curve: self, line: .vertical(at: x))
        return Set(ts.map { t in self[t].y })
    }
    
    public func xs(y: Double) -> Set<Double> {
        let ts = cardano(curve: self, line: .horizontal(at: y))
        return Set(ts.map { t in self[t].x })
    }
    
    public func simplified(accuracy: Double) -> [Point] {
        fatalError("Not yet implemented!")
    }
}

func cubeRoot(_ value: Double) -> Double {
    return value > 0 ? pow(value, 1/3) : -pow(-value, 1/3)
}

/// - Returns: The `t` values intersecting where the given `curve` intersects the given line.
///
/// - Author: Pomax
/// - See: http://jsbin.com/payifoxeho/edit?html,css,js
/// - Note: Cardano's algorithm, based on
/// http://www.trans4mind.com/personal_development/mathematics/polynomials/cubicAlgebra.htm.
///
func cardano(curve: CubicBezierCurve, line: Line) -> Set<Double> {
    
    func align(curve: CubicBezierCurve, with line: Line) -> CubicBezierCurve {
        
        let points = [curve.start, curve.control1, curve.control2, curve.end]
        let tx = line.start.x
        let ty = line.start.y
        let a = -atan2(line.end.y - ty, line.end.x - tx)
        
        let alignedPoints = points.map { point in
            Point(
                x: (point.x - tx) * cos(a) - (point.y - ty) * sin(a),
                y: (point.x - tx) * sin(a) + (point.y - ty) * cos(a)
            )
        }

        return CubicBezierCurve(
            start: alignedPoints[0],
            end: alignedPoints[3],
            control1: alignedPoints[1],
            control2: alignedPoints[2]
        )
    }
    
    let tau: Double = 2 * .pi
    
    let aligned = align(curve: curve, with: line)
    
    let pa = aligned.start.y
    let pb = aligned.control1.y
    let pc = aligned.control2.y
    let pd = aligned.end.y
    
    let d = (-pa + 3 * pb - 3 * pc + pd)
    let a = (3 * pa - 6 * pb + 3 * pc) / d
    let b = (-3 * pa + 3 * pb) / d
    let c = pa / d
    
    let p = (3 * b - a * a) / 3
    let p3 = p/3
    let q = (2 * pow(a,3) - 9 * a * b + 27 * c) / 27
    let q2 = q/2
    let discriminant = pow(q2,2) + pow(p3,3)
    
    if discriminant < 0 {
        let mp3 = -p/3
        let mp33 = pow(mp3,3)
        let r = sqrt(mp33)
        let t = -q/(2*r)
        let cosphi = t < -1 ? -1 : t > 1 ? 1 : t
        let phi = acos(cosphi)
        let crtr = cubeRoot(r)
        let t1 = 2 * crtr
        let x1 = t1 * cos(phi / 3) - a / 3;
        let x2 = t1 * cos((phi + tau)/3) - a / 3;
        let x3 = t1 * cos((phi + 2 * tau) / 3) - a / 3;
        return [x1, x2, x3]
    } else if(discriminant == 0) {
        let u1 = q2 < 0 ? cubeRoot(-q2) : -cubeRoot(q2)
        let x1 = 2 * u1 - a / 3
        let x2 = -u1 - a / 3
        return [x1,x2]
    } else {
        let sd = sqrt(discriminant)
        let u1 = cubeRoot(-q2 + sd)
        let v1 = cubeRoot(q2 + sd)
        let x1 = u1 - v1 - a / 3
        return [x1]
    }
}
