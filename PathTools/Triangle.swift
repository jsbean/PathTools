//
//  Triangle.swift
//  PathTools
//
//  Created by James Bean on 6/5/17.
//
//

import Darwin

public struct Triangle: ConvexPolygonProtocol {
    
    public var angle: Angle {
        
        let p1 = vertices[0]
        let center = vertices[1]
        let p2 = vertices[2]
        
        let a = pow(center.x - p1.x, 2) + pow(center.y - p1.y, 2)
        let b = pow(center.x - p2.x, 2) + pow(center.y - p2.y, 2)
        let c = pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2)
        
        return Angle(radians: acos((a + b - c) / sqrt(4 * a * b)))
    }
    
    public let vertices: [Point]
    
    public init(_ a: Point, _ b: Point, _ c: Point) {
        self.vertices = [a,b,c]
    }
    
    public init(vertices: [Point]) {
        
        guard vertices.count == 3 else {
            fatalError("A triangle must have three vertices!")
        }
        
        self.vertices = vertices
    }

    public func isConvex(rotation: Rotation) -> Bool {
        
        let (a,b,c) = (vertices[0], vertices[1], vertices[2])
        let crossProduct = ((a.x * (c.y - b.y)) + (b.x * (a.y - c.y)) + (c.x * (b.y - a.y)))
        
        switch rotation {
        case .counterClockwise:
            return crossProduct < 0 ? true : false
        case .clockwise:
            return crossProduct < 0 ? false : true
        }
    }
    
    public func contains(_ point: Point) -> Bool {

        func sign(a: Point, b: Point, c: Point) -> FloatingPointSign {
            return ((a.x - c.x) * (b.y - c.y) - (b.x - c.x) * (a.y - c.y)).sign
        }

        let b1 = sign(a: point, b: vertices[0], c: vertices[1])
        let b2 = sign(a: point, b: vertices[1], c: vertices[2])
        let b3 = sign(a: point, b: vertices[2], c: vertices[0])
        
        return (b1 == b2) && (b2 == b3)
    }
}

extension Triangle: Equatable {
    
    public static func == (lhs: Triangle, rhs: Triangle) -> Bool {
        return lhs.vertices == rhs.vertices
    }
}
