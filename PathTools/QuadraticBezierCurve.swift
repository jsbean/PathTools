//
//  QuadraticBezierCurve.swift
//  PathTools
//
//  Created by James Bean on 11/24/16.
//
//

import QuartzCore

public struct QuadraticBezierCurve: BezierCurve {
    
    public let start: CGPoint
    
    public let end: CGPoint
    
    let controlPoint: CGPoint
    
    public func ys(x: CGFloat) -> [CGFloat] {
    
        return []
    }
    
    public func x(y: CGFloat) -> CGFloat {
        return 0
    }
    
    // TODO: Consider using `Interval`
    func isWithinBound(x: CGFloat) -> Bool {
        let (min, max) = ordered(start.y, end.y)
        return x <= min && x >= max
    }
    
    func isWithinBound(y: CGFloat) -> Bool {
        
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
