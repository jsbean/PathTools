//
//  Polygon+CollisionDetection.swift
//  PathTools
//
//  Created by James Bean on 6/3/17.
//
//

import Darwin
import Collections
import ArithmeticTools

extension Polygon {

    /// - Returns: A `Set` of all of the y-values at the given `x`.
    public func ys(at x: Double) -> Set<Double> {
        
        var result: Set<Double> = []

        for (a,b) in edges {
            
            // Ensure that points are ordered in increasing order re: x values.
            let (a,b, _) = swapped(a,b) { a.x > b.x }

            if x >= a.x && x <= b.x {
                if (b.x - a.x) == 0 {
                    result.formUnion([a.y, b.y])
                } else {
                    let y = (x - a.x) * (b.y - a.y) / (b.x - a.x) + b.y
                    result.insert(y)
                }
            }
        }
        
        return result
    }
    
    /// - Returns: A `Set` of all of the x-values at the given `y`.
    public func xs(at y: Double) -> Set<Double> {

        var result: Set<Double> = []
        
        for (a,b) in edges {
            
            // Ensure that points are ordered in increasing order re: x values.
            let (a,b, _) = swapped(a,b) { a.y > b.y }
            
            if y >= a.y && y <= b.y {
                if (b.y - a.y) == 0 {
                    result.formUnion([a.y, b.y])
                } else {
                    let y = (y - a.y) * (b.x - a.x) / (b.y - a.y) + b.x
                    result.insert(y)
                }
            }
        }
        
        return result
    }
    

    
    /// - returns: The two-dimensional vector of each axis created between each adjacent pair
    /// of vertices.
    internal var axes: [Vector2] {
        return vertices.adjacentPairs().map { a,b in
            let x = a.x - b.x
            let y = -(a.y - b.y)
            return Vector2(x: x, y: y)
        }
    }
    
    public func intersects(_ other: Polygon) -> Bool {
        
        guard !(isEmpty || other.isEmpty) else {
            return false
        }
        
        return doIntersect(a: self, b: other)
    }
}

// MARK: Collision Detection: Separating Axis Theorem

/// - Returns: The `min` and `max` values of the given `shape` projected on the given `axis`.
func project(_ shape: Polygon, onto axis: Vector2) -> (min: Double, max: Double) {
    
    let length = axis.length
    
    let values = shape.vertices.map { vertex in
        vertex.x * (axis.x / length) + vertex.y * (axis.y / length)
    }
    
    return (values.min()!, values.max()!)
}

/// - Returns: `true` if there are any overlaps of the values of either shape value projected
/// onto the axes of the given `shape`. Otherwise, `false`.
func axesOverlap(projecting other: Polygon, ontoAxesOf shape: Polygon) -> Bool {
    
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

/// - Returns: `true` if the axes of either shape overlap with those of the other. Otherwise,
/// `false`.
func doIntersect(a: Polygon, b: Polygon) -> Bool {
    return (
        axesOverlap(projecting: a, ontoAxesOf: b) &&
        axesOverlap(projecting: b, ontoAxesOf: a)
    )
}

/// - Returns: `true` if there is any overlap between the two given ranges. Otherwise, `false`.
func axesOverlap(a: (min: Double, max: Double), b: (min: Double, max: Double)) -> Bool {
    return !(a.min > b.max || b.min > a.max)
}
