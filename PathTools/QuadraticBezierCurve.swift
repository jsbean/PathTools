//
//  QuadraticBezierCurve.swift
//  PathTools
//
//  Created by James Bean on 11/24/16.
//
//

import ArithmeticTools
import QuartzCore

public struct QuadraticBezierCurve: BezierCurve {
    
    private struct CoefficientCollection {
        
        typealias Coefficient = (x: CGFloat, y: CGFloat)
        
        // TODO: make better names
        let a, b, c: Coefficient
    }
    
    public let start: CGPoint
    
    public let end: CGPoint
    
    let controlPoint: CGPoint
    
    public func ys(x: CGFloat) -> [CGFloat] {
        
        guard contains(x: x) else {
            return []
        }
        
        let coefficients = CoefficientCollection(
            a: (start.x, start.y),
            b: (2.0 * (controlPoint.x - start.x), 2.0 * (controlPoint.y - start.y)),
            c: (
                start.x - (2.0 * controlPoint.x) + end.x,
                start.y - (2.0 * controlPoint.y) + end.y
            )
        )

        let c = coefficients.a.x - x
        let b = coefficients.b.x
        var a = coefficients.c.x
        var d = pow(b, 2) - (4 * a * c)
        
        guard d >= 0 else {
            return []
        }
        
        d = sqrt(d)
        a = 1 / (a + a)
        
        // two potential values for t
        let t0 = (d - b) * a
        let t1 = (-b - d) * a
        
        return [t0, t1]
            .flatMap(y)
            .filter { $0 >= 0 && $0 <= 1 }
    }
    
    public func x(y: CGFloat) -> CGFloat {
        return 0
    }
    
    func contains(x: CGFloat) -> Bool {
        let (min, max) = ordered(start.y, end.y)
        return x >= min && x <= max
    }
    
    func contains(y: CGFloat) -> Bool {
        let (min, max) = ordered(start.x, end.x)
        return y >= min && y <= max
    }
    
    // `t` is between `0.0 ... 1.0`
    // TODO: Break out into individual `let`s
    func x(t: CGFloat) -> CGFloat {
        let complement = 1 - t
        let x = (
            pow(complement, 2) * start.x +
            2 * complement * t * controlPoint.x +
            pow(t, 2) * end.x
        )
        return x
    }
    
    // `t` is between `0.0 ... 1.0`
    // TODO: Break out into individual `let`s
    func y(t: CGFloat) -> CGFloat {
        let complement = 1 - t
        let y = (pow(complement, 2) * start.y) +
            (2 * complement * t * controlPoint.y) +
            (pow(t, 2) * end.y)
        return y
    }
}
