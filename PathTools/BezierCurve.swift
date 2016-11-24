//
//  BezierCurve.swift
//  PathTools
//
//  Created by James Bean on 11/24/16.
//
//

import QuartzCore

public protocol BezierCurve {
    
    var start: CGPoint { get set }
    
    var end: CGPoint { get set }
    
    func ys(x: CGFloat) -> [CGFloat]
    
    func x(y: CGFloat) -> CGFloat
}
