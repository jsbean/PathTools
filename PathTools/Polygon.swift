//
//  Polygon.swift
//  PathTools
//
//  Created by James Bean on 6/5/17.
//
//

import Collections
import ArithmeticTools

/// No guarantees of sementics of Convex / Concave
public struct Polygon: PolygonProtocol {
    
    public var collisionDetectable: ConvexPolygonContainer {
        return isConvex
            ? ConvexPolygonContainer(ConvexPolygon(vertices: vertices))
            : ConvexPolygonContainer(triangulated)
    }
    
    /// Triangulate counter-clockwise `Polygon`.
    public var triangulated: [Triangle] {
        
        // Uses Ear Clipping method to split `Polygon` into array of `Triangle` values.
        
        /// - Returns: A triangle, if valid for snipping. Otherwise, `nil`.
        ///
        /// A triangle valid for snipping satisfies two requirements:
        /// - It is convex, given the order of traversal.
        /// - There are no remaining vertices contained within its area.
        ///
        func ear(at index: Int, of vertices: [Point]) -> Triangle? {

            // Create a circular view of the data for wrapping over endIndex
            let vertices = vertices.circular
            
            // Triangle that we want to check
            let triangle = Triangle(vertices: vertices[from: index - 1, through: index + 1])
            
            // An ear must be convex, given the order of traversal.
            guard triangle.isConvex(rotation: .counterClockwise) else {
                return nil
            }
            
            let remaining = vertices[after: index + 1, upTo: index - 1]
            guard !triangle.contains(anyOf: remaining) else {
                return nil
            }
            
            return triangle
        }
        
        /// Attempts to clip off an ear at the given `index`, from the given `vertices`.
        /// If we are able to do so, we snip off the tip, and drop the ear into `ears`.
        /// Otherwise, we move on to the next vertex.
        ///
        /// - Returns: Array of `Triangle` values that cover the same area as `Polygon`.
        func clipEar(at index: Int, from vertices: [Point], into ears: [Triangle])
            -> [Triangle]
        {
            
            // Base case: If there are only three vertices left, we have the last triangle!
            guard vertices.count > 3 else {
                return ears + Triangle(
                    vertices: vertices.circular[from: index - 1, through: index + 1]
                )
            }
            
            // If no ear found at current index, continue on to the next vertex.
            guard let ear = ear(at: index, of: vertices) else {
                return clipEar(at: index + 1, from: vertices, into: ears)
            }
            
            // Snip off tip, and proceed.
            return clipEar(at: index, from: vertices.removing(at: index), into: ears + ear)
        }
        
        return clipEar(at: 0, from: counterClockwise.vertices, into: [])
    }
    
    public var clockwise: Polygon {
        return rotation == .clockwise
            ? self
            : Polygon(vertices: self.vertices.reversed())
    }
    
    public var counterClockwise: Polygon {
        return rotation == .counterClockwise
            ? self
            : Polygon(vertices: self.vertices.reversed())
    }
    
    /// - Returns: `true` if `Polygon` is convex. Otherwise, `false`.
    internal var isConvex: Bool {
        let signs: [FloatingPointSign] = triangles.map {
            let (p1, center, p2) = ($0.vertices[0], $0.vertices[1], $0.vertices[2])
            return zCrossProduct(p1: p1, center: center, p2: p2).sign
        }
        return signs.isHomogeneous
    }
    
    public let vertices: [Point]
    
    public init(vertices: [Point]) {
        self.vertices = vertices
    }
    
    // TEMP:
    public func xs(at y: Double) -> Set<Double> {
        fatalError("Not yet implemented!")
    }
    
    public func ys(at x: Double) -> Set<Double> {
        fatalError("Not yet implemented!")
    }
}

extension Polygon: Equatable {
    
    public static func == (lhs: Polygon, rhs: Polygon) -> Bool {
        return lhs.vertices == rhs.vertices
    }
}
