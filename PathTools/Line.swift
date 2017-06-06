//
//  Line.swift
//  PathTools
//
//  Created by James Bean on 6/6/17.
//
//

import Darwin
import ArithmeticTools

public struct Line {
    
    public var length: Double {
        return sqrt(pow(end.x - start.x, 2) + pow(end.y - start.y, 2))
    }
    
    public var vector: Vector2 {
        return Vector2(x: end.x - start.x, y: end.y - start.y)
    }
    
    public let start: Point
    public let end: Point
    
    public init(start: Point, end: Point) {
        self.start = start
        self.end = end
    }
    
    public init(points: [Point]) {
        
        guard points.count == 2 else {
            fatalError("A triangle must have three vertices!")
        }
        
        self.start = points[0]
        self.end = points[1]
    }
}
