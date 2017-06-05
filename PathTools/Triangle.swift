//
//  Triangle.swift
//  PathTools
//
//  Created by James Bean on 6/5/17.
//
//

public class Triangle: Polygon {

    public init(_ a: Point, _ b: Point, _ c: Point) {
        super.init(vertices: [a,b,c])
    }
    
    public convenience init(vertices triplet: (Point, Point, Point)) {
        let (a,b,c) = triplet
        self.init(a,b,c)
    }
    
    public init <C: Collection> (_ vertices: C) where C.Iterator.Element == Point {
        
        guard vertices.count == 3 else {
            fatalError("A Triangle must have three points!")
        }
        
        super.init(vertices: Array(vertices))
    }
    
    public func isConvex(order: Order) -> Bool {
        let (a,b,c) = (vertices[0], vertices[1], vertices[2])
        let crossProduct = ((a.x * (c.y - b.y)) + (b.x * (a.y - c.y)) + (c.x * (b.y - a.y)))
        switch order {
        case .counterClockwise:
            return crossProduct < 0 ? true : false
        case .clockwise:
            return crossProduct < 0 ? false : true
        }
    }

    public override func contains(_ point: Point) -> Bool {
        
        func sign(a: Point, b: Point, c: Point) -> FloatingPointSign {
            return ((a.x - c.x) * (b.y - c.y) - (b.x - c.x) * (a.y - c.y)).sign
        }
        
        let b1 = sign(a: point, b: vertices[0], c: vertices[1])
        let b2 = sign(a: point, b: vertices[1], c: vertices[2])
        let b3 = sign(a: point, b: vertices[2], c: vertices[0])
        
        return (b1 == b2) && (b2 == b3)
    }
    
    public func contains(anyOf points: [Point]) -> Bool {
        
        for point in points where contains(point) {
            return true
        }
        
        return false
    }
}
