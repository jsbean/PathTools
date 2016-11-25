//
//  LinearBezierCurve.swift
//  PathTools
//
//  Created by James Bean on 11/24/16.
//
//

import QuartzCore

// Straight line
public struct LinearBezierCurve: BezierCurve {
    
    public let start: CGPoint
    public let end: CGPoint
    
    public init(start: CGPoint, end: CGPoint) {
        self.start = start
        self.end = end
    }
    
    public func ys(x: CGFloat) -> [CGFloat] {
        let horizontalOffset = (x - start.x)
        let width = (end.x - start.x)
        let height = end.y - start.y
        let verticalOffset = start.y
        let y = verticalOffset + (horizontalOffset / width) * height
        return [y]
    }
    
    public func x(y: CGFloat) -> CGFloat {
        fatalError("Not yet implemented!")
    }
}
