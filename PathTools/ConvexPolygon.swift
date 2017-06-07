//
//  ConvexPolygon.swift
//  PathTools
//
//  Created by James Bean on 6/6/17.
//
//

import Collections
import ArithmeticTools

/// Concrete ConvexPolygon.
public struct ConvexPolygon: ConvexPolygonProtocol {

    public let vertices: VertexCollection
    
    public init <S: Sequence> (vertices: S) where S.Iterator.Element == Point {
        
        let vertices = CircularArray(vertices)
        
        guard isConvex(vertexCollection: vertices) else {
            fatalError("Cannot create a ConvexPolygon with a concave vertex collection")
        }
        
        self.vertices = vertices
    }
}

public func zCrossProduct(p1: Point, center: Point, p2: Point) -> Double {
    return (p1.x - center.x) * (center.y - p2.y) - (p1.y - center.y) * (center.x - p2.x)
}

public func isConvex(vertexCollection: VertexCollection) -> Bool {
    let vertices = vertexCollection
    return vertices.indices
        .lazy
        .map { index in vertices[from: index - 1, through: index + 1] }
        .map { zCrossProduct(p1: $0[0], center: $0[1], p2: $0[2]) }
        .map { $0.sign }
        .isHomogeneous
}
