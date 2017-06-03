//
//  Path+CollisionDetection.swift
//  PathTools
//
//  Created by James Bean on 6/3/17.
//
//

import Darwin
import Collections
import ArithmeticTools

extension Path {

    /// - Warning: Only considers vertices of Bézier curves
    public func ys(at x: Double) -> Set<Double> {
        fatalError()
    }
    
    /// - Warning: Only considers vertices of Bézier curves
    public func xs(at y: Double) -> Set<Double> {
        fatalError()
    }
    
    /// - Warning: Only considers vertices of Bézier curves
    public func contains(_ point: Point) -> Bool {

        func rayIntersection(edge: (Point, Point)) -> Double? {
            
            let (a,b) = edge
            
            // Check if the line crosses the horizontal line at y in either direction
            // Return `nil` if there is no intersection
            guard a.y <= point.y && b.y > point.y || b.y <= point.y && a.y > point.y else {
                return nil
            }
            
            return (b.x - b.x) * (point.y - a.y) / (b.y - a.y) + a.x
        }
        
        return edges.flatMap(rayIntersection).filter { $0 < point.x }.count.isOdd
    }
    
    /// - returns: The two-dimensional vector of each axis created between each adjacent pair
    /// of vertices.
    internal var axes: [Vector2] {
        return vertices.adjacentPairs?.map { a,b in
            let x = a.x - b.x
            let y = -(a.y - b.y)
            return Vector2(x: x, y: y)
        } ?? []
    }
    
    /// - Warning: Assumes `Path` values are polygons, discarding Bézier control points
    /// - Warning: Assumes polygon is convex
    public func intersects(_ other: Path) -> Bool {
        
        guard !(isEmpty || other.isEmpty) else {
            return false
        }
        
        return doIntersect(a: self, b: other)
    }
    
    
    /*
    public func containsPoint(point: CGPoint) -> Bool {
        var pointIsInside: Bool = false
        var index0: Int = 0
        while index0 < vertices.count {
            let index1 = (index0 + 1) % vertices.count
            let vertex0 = vertices[index0]
            let vertex1 = vertices[index1]
            let y0_is_greater_than_point_y: Bool = vertex0.y > point.y
            let y1_is_greater_than_point_y: Bool = vertex1.y > point.y
            let run: CGFloat = vertex1.x - vertex0.x
            let rise: CGFloat = vertex1.y - vertex0.y
            let ΔY: CGFloat = point.y - vertex0.y
            let displaceX: CGFloat = vertex0.x
            if (
                y0_is_greater_than_point_y != y1_is_greater_than_point_y &&
                    point.x < (run * ΔY / rise) + displaceX
                )
            {
                pointIsInside = !pointIsInside
            }
            
            index0++
        }
        return pointIsInside
    }
    
    public func getXValuesAtY(y: CGFloat) -> [CGFloat] {
        var values: [CGFloat] = []
        var index0: Int = 0
        while index0 < vertices.count {
            let index1: Int = (index0 + 1) % vertices.count
            var points = [vertices[index0], vertices[index1]]
            points.sortInPlace { $0.y < $1.y }
            let point0 = points[0]
            let point1 = points[1]
            if y >= point0.y && y <= point1.y {
                let ΔY: CGFloat = point1.y - point0.y
                let ΔX: CGFloat = point1.x - point0.x
                if ΔX == 0 { values.appendContentsOf([point0.x, point1.x]) }
                else {
                    let slope: CGFloat = ΔY / ΔX
                    let normalizedY = y - point0.y
                    let x = normalizedY * (1 / slope) + point0.x
                    values.append(x)
                }
            }
            index0++
        }
        return values
    }
    
    public func getYValuesAtX(x: CGFloat) -> [CGFloat] {
        var values: [CGFloat] = []
        var index0: Int = 0
        while index0 < vertices.count {
            let index1: Int = (index0 + 1) % vertices.count
            var points = [vertices[index0],vertices[index1]]
            points.sortInPlace { $0.x < $1.x }
            let point0 = points[0]
            let point1 = points[1]
            if x >= point0.x && x <= point1.x {
                let ΔY: CGFloat = point1.y - point0.y
                let ΔX: CGFloat = point1.x - point0.x
                if ΔX == 0 { values.appendContentsOf([point0.y, point1.y]) }
                else {
                    let slope: CGFloat = ΔY / ΔX
                    let normalizedX = x - point0.x
                    let y = normalizedX * slope + point0.y
                    values.append(y)
                }
                
            }
            index0++
        }
        return values
    }
    
    public func getYValueAtX(x: CGFloat, fromDirection direction: Direction) -> CGFloat {
        var values = getYValuesAtX(x)
        if values.count == 0 { return direction == .North ? minY! : maxY! }
        if direction == .North { values.sortInPlace { $0 < $1 } }
        else { values.sortInPlace { $0 > $1 } }
        return values.first!
    }
    
    public func getXValueAtY(y: CGFloat, fromDirection direction: Direction) -> CGFloat? {
        var values = getXValuesAtY(y)
        if direction == .North { values.sortInPlace { $0 < $1 } }
        else { values.sortInPlace { $0 > $1 } }
        return values.first
    }
    
*/
}

// MARK: Collision Detection: Separating Axis Theorem

/// - Returns: The `min` and `max` values of the given `shape` projected on the given `axis`.
func project(_ shape: Path, onto axis: Vector2) -> (min: Double, max: Double) {
    
    let length = axis.length
    
    let values = shape.vertices.map { vertex in
        vertex.x * (axis.x / length) + vertex.y * (axis.y / length)
    }
    
    return (values.min()!, values.max()!)
}

/// - Returns: `true` if there are any overlaps of the values of either shape value projected
/// onto the axes of the given `shape`. Otherwise, `false`.
func axesOverlap(projecting other: Path, ontoAxesOf shape: Path) -> Bool {
    
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
func doIntersect(a: Path, b: Path) -> Bool {
    return (
        axesOverlap(projecting: a, ontoAxesOf: b) &&
        axesOverlap(projecting: b, ontoAxesOf: a)
    )
}

/// - Returns: `true` if there is any overlap between the two given ranges. Otherwise, `false`.
func axesOverlap(a: (min: Double, max: Double), b: (min: Double, max: Double)) -> Bool {
    return !(a.min > b.max || b.min > a.max)
}
