//
//  PolygonProtocol.swift
//  PathTools
//
//  Created by James Bean on 6/6/17.
//
//

import Collections
import ArithmeticTools

/// Interface for polygonal shapes.
public protocol PolygonProtocol: Shape {
    
    // MARK: - Instance Properties
    var rotation: Rotation { get }
    var triangles: [Triangle] { get }
    var faces: [Line] { get }
    var angles: [Angle] { get }
    var path: Path { get }
    var collisionDetectable: ConvexPolygonContainer { get }
    
    var vertices: CircularArray<Point> { get }
    
    // MARK: - Initializers
    
    init(vertices: [Point])
    
    // MARK: - Instance Methods
    
    func contains(_ point: Point) -> Bool
}

extension PolygonProtocol {

    /// - returns: Array of the line values comprising the faces of the `PolygonProtocol`-
    /// conforming type.
    public var faces: [Line] {
        let vertices = self.vertices
        return vertices.indices.map { index in
            Line(points: vertices[from: index, through: index + 1])
        }
    }
    
    /// - Returns: The two-dimensional vector of each axis created between each adjacent pair
    /// of vertices.
    internal var axes: [Vector2] {
        return faces.map { $0.vector }
    }
    
    /// - Returns: Whether vertices are arranged clockwise / counterclockwise.
    public var rotation: Rotation {
        let sum = faces.reduce(Double(0)) { accum, cur in
            let (a,b) = (cur.start, cur.end)
            return accum + (b.x - a.x) * (b.y + a.y)
        }
        return sum > 0 ? .clockwise : .counterClockwise
    }
    
    /// - Returns: Array of triangles created with each adjacent triple of vertices.
    public var triangles: [Triangle] {
        let vertices = self.vertices
        return vertices.indices.map { index in
            Triangle(vertices: vertices[from: index - 1, through: index + 1])
        }
    }
    
    /// - Returns: Array of the angles.
    public var angles: [Angle] {
        return triangles.map { $0.angle }
    }
    
    /// - Returns: `Path` representation. 
    public var path: Path {
        let (head, tail) = vertices.destructured!
        let first: PathElement = .move(head)
        let rest: [PathElement] = tail.map { .line($0) }
        let last: PathElement = .close
        return Path(first + rest + last)
    }
    
    // MARK: - Collision Detection
    
    /// - Returns: `true` if a `Path` contains the given `point`.
    ///
    /// - Note: Valid for convex and concave polygons!
    public func contains(_ point: Point) -> Bool {
        
        func rayIntersection(edge: Line) -> Double? {
            
            let (a,b) = (edge.start, edge.end)
            
            // Check if the line crosses the horizontal line at y in either direction
            // Return `nil` if there is no intersection
            guard a.y <= point.y && b.y > point.y || b.y <= point.y && a.y > point.y else {
                return nil
            }
            
            // Return the point where the ray intersects the edge
            return (b.x - b.x) * (point.y - a.y) / (b.y - a.y) + a.x
        }
        
        // If the amount of crossings is odd, we contain the `point`. Otherwise, we don't.
        return faces.flatMap(rayIntersection).filter { $0 < point.x }.count.isOdd
    }
    
    public func contains(anyOf points: [Point]) -> Bool {
        for point in points where contains(point) {
            return true
        }
        return false
    }
    
    /// - Returns: A `Set` of all of the y-values at the given `x`.
    public func ys(at x: Double) -> Set<Double> {
        
        var result: Set<Double> = []
        
        for face in faces {
            
            // Ensure that points are ordered in increasing order re: x values.
            let (a,b, _) = swapped(face.start, face.end) { face.start.x > face.end.x }
            
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
        
        for face in faces {
            
            // Ensure that points are ordered in increasing order re: x values.
            let (a,b, _) = swapped(face.start,face.end) { face.start.y > face.end.y }
            
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
}
