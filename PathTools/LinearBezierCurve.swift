//
//  LinearBezierCurve.swift
//  PathTools
//
//  Created by James Bean on 11/24/16.
//
//

import Darwin
import GeometryTools

// Straight line
public struct LinearBezierCurve: BezierCurve {
    
    public let start: Point
    public let end: Point
    
    public init(start: Point, end: Point) {
        self.start = start
        self.end = end
    }
    
    public subscript (t: Double) -> Point {
        let rise = (end - start).y
        let run = (end - start).x
        let slope = rise/run
        let angle = tan(slope)
        let length = hypot(rise, run) * t
        let x = cos(angle) * length
        let y = sin(angle) * length
        return Point(x: x, y: y)
    }

    public func ys(x: Double) -> Set<Double> {
        let verticalOffset = start.y
        let height = end.y - start.y
        let horizontalOffset = x - start.x
        let width = end.x - start.x
        let y = verticalOffset + (horizontalOffset / width) * height
        return Set([y])
    }
    
    public func xs(y: Double) -> Set<Double> {
        fatalError("Not yet implemented!")
    }
    
    public func simplified(accuracy: Double) -> [Point] {
        fatalError("Not yet implemented!")
    }
}
