//
//  PolyBezier.swift
//  PathTools
//
//  Created by James Bean on 6/6/17.
//
//

public struct PolyBezier: Shape {
    
    public var collisionDetectable: ConvexPolygonContainer {
        let vertices = curves.flatMap { $0.simplified(accuracy: 0.1) }
        return ConvexPolygonContainer(ConvexPolygon(vertices: vertices))
    }

    public let curves: [BezierCurve]
    
    public func xs(at y: Double) -> Set<Double> {
        fatalError("Not yet implemented!")
    }
    
    public func ys(at x: Double) -> Set<Double> {
        fatalError("Not yet implemented!")
    }
}
