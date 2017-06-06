//
//  Shape.swift
//  PathTools
//
//  Created by James Bean on 6/6/17.
//
//

/// Shape.
public protocol Shape {
    var collisionDetectable: ConvexPolygonContainer { get }
    func ys(at x: Double) -> Set<Double>
    func xs(at y: Double) -> Set<Double>
}
