//
//  CubicBezierCurve.swift
//  PathTools
//
//  Created by James Bean on 11/24/16.
//
//

public struct CubicBezierCurve: BezierCurve {
    
    public let start: Point
    public let end: Point
    
    public init(start: Point, end: Point) {
        self.start = start
        self.end = end
    }
    
    public func ys(x: Double) -> Set<Double> {
        let verticalOffset = start.y
        let height = end.y - start.y
        let horizontalOffset = x - start.x
        let width = end.x - start.x
        let y = verticalOffset + (horizontalOffset / width) * height
        return Set([y])
    }
    
    public func x(y: Double) -> Double {
        fatalError("Not yet implemented!")
    }
    
    public func simplified(accuracy: Double) -> [Point] {
        fatalError("Not yet implemented!")
    }
}
