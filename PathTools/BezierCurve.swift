//
//  BezierCurve.swift
//  PathTools
//
//  Created by James Bean on 11/24/16.
//
//

import QuartzCore

public protocol BezierCurve {
 
    /// Start point of Bézier curve.
    var start: CGPoint { get }
    
    /// End point of Bézier curve.
    var end: CGPoint { get }
    
    /// - returns: All y-values for a given `x`.
    func ys(x: CGFloat) -> Set<CGFloat>
    
    /// - returns: The x-value for a given `y`.
    func x(y: CGFloat) -> CGFloat
}
