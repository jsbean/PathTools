//
//  CollisionDetection.swift
//  PathTools
//
//  Created by James Bean on 6/6/17.
//
//

import ArithmeticTools

public func collision(_ a: Shape, _ b: Shape) -> Bool {
    
    for a in a.collisionDetectable.polygons {
        for b in b.collisionDetectable.polygons {
            if collision(a,b) {
                return true
            }
        }
    }
    
    return false
}

/// - Returns: `true` if the axes of either shape overlap with those of the other. Otherwise,
/// `false`.
func collision(_ a: ConvexPolygonProtocol, _ b: ConvexPolygonProtocol) -> Bool {
    return (
        axesOverlap(projecting: a, ontoAxesOf: b) &&
        axesOverlap(projecting: b, ontoAxesOf: a)
    )
}

/// - Returns: `true` if there are any overlaps of the values of either shape value projected
/// onto the axes of the given `shape`. Otherwise, `false`.
func axesOverlap(
    projecting other: ConvexPolygonProtocol,
    ontoAxesOf shape: ConvexPolygonProtocol
) -> Bool
{
    
    // Project `shape` and `other` onto each axis of `shape`.
    for axis in shape.axes {
        
        let shapeValues = project(shape, onto: axis)
        let otherValues = project(other, onto: axis)
        
        // If we ever see light between two shapes, we short-circuit to `false`
        if !axesOverlap(a: shapeValues, b: otherValues) {
            return false
        }
    }
    
    // Each pair of axes overlapped
    return true
}

/// - Returns: `true` if there is any overlap between the two given ranges. Otherwise, `false`.
func axesOverlap(a: (min: Double, max: Double), b: (min: Double, max: Double)) -> Bool {
    return !(a.min > b.max || b.min > a.max)
}

// MARK: Collision Detection: Separating Axis Theorem

/// - Returns: The `min` and `max` values of the given `shape` projected on the given `axis`.
func project(_ shape: ConvexPolygonProtocol, onto axis: Vector2)
    -> (min: Double, max: Double)
{
    
    let length = axis.length
    
    let values = shape.vertices.map { vertex in
        vertex.x * (axis.x / length) + vertex.y * (axis.y / length)
    }
    
    return (values.min()!, values.max()!)
}



