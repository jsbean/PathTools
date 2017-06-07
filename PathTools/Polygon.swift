//
//  Polygon.swift
//  PathTools
//
//  Created by James Bean on 6/5/17.
//
//

import Collections
import ArithmeticTools

/// Polgonal shape containing at least three vertices.
public struct Polygon: PolygonProtocol {
    
    /// - Returns: `ConvexPolygonContainer` that can be used for collision detection.
    ///
    /// - Note: In the case that this `Polygon` is convex, the `ConvexPolygonContainer` is
    /// initialized with it. In the case the this `Polygon` is concave, it is broken up into
    /// the minimum number of triangles through an Ear Clipping method.
    public var collisionDetectable: ConvexPolygonContainer {
        return isConvex
            ? ConvexPolygonContainer(ConvexPolygon(vertices: vertices))
            : ConvexPolygonContainer(triangulated)
    }
    
    /// Triangulate counter-clockwise `Polygon`.
    ///
    /// - Note: Uses Ear Clipping method to split concave polygon into array of `Triangle` 
    /// values.
    internal var triangulated: [Triangle] {
        
        /// - Returns: A triangle, if valid for clipping. Otherwise, `nil`.
        ///
        /// A triangle valid for cipping satisfies two requirements:
        /// - It is convex, given the order of traversal.
        /// - There are no remaining vertices contained within its area.
        ///
        func ear(at index: Int, of vertices: VertexCollection) -> Triangle? {
            
            // Triangle that may be an ear. We don't know yet.
            let triangle = Triangle(vertices: vertices[from: index - 1, through: index + 1])
            
            // For the triangle to be an ear, it must be convex, given the order of traversal.
            guard triangle.isConvex(rotation: .counterClockwise) else {
                return nil
            }
            
            // For the triangle to be an ear, it must not have any remaining vertices within 
            // its area.
            guard !triangle.contains(anyOf: vertices[after: index + 1, upTo: index - 1]) else {
                return nil
            }
            
            return triangle
        }
        
        /// Attempts to clip off an ear at the given `index`, from the given `vertices`.
        /// If we are able to do so, we snip off the tip, and drop the ear into `ears`.
        /// Otherwise, we move on to the next vertex.
        ///
        /// - Returns: Array of `Triangle` values that cover the same area as `Polygon`.
        ///
        func clipEar(at index: Int, from vertices: VertexCollection, into ears: [Triangle])
            -> [Triangle]
        {
            
            // Base case: If there are only three vertices left, we have the last triangle!
            guard vertices.count > 3 else {
                let ear = Triangle(vertices: vertices[from: index - 1, through: index + 1])
                return ears + ear
            }
            
            // If no ear found at current index, continue on to the next vertex.
            guard let ear = ear(at: index, of: vertices) else {
                return clipEar(at: index + 1, from: vertices, into: ears)
            }
            
            // Snip off tip, and proceed.
            return clipEar(at: index, from: vertices.removing(at: index), into: ears + ear)
        }
        
        /// Ensure that the vertices are ordered in a counter-clockwise fasion.
        /// Traverse a circular view of the vertices to allow the wrapping around its end.
        return clipEar(at: 0, from: counterClockwise.vertices, into: [])
    }
    
    /// View of `Polygon` in which the vertices are ordered in a clockwise fashion.
    internal var clockwise: Polygon {
        return rotation == .clockwise ? self : Polygon(vertices: vertices.reversed())
    }
    
    /// View of `Polygon` in which the vertices are ordered in a counter-clockwise fashion.
    internal var counterClockwise: Polygon {
        return rotation == .counterClockwise ? self : Polygon(vertices: vertices.reversed())
    }
    
    /// - Returns: `true` if `Polygon` is convex. Otherwise, `false`.
    internal var isConvex: Bool {
        let signs: [FloatingPointSign] = triangles.map {
            let (p1, center, p2) = ($0.vertices[0], $0.vertices[1], $0.vertices[2])
            return zCrossProduct(p1: p1, center: center, p2: p2).sign
        }
        return signs.isHomogeneous
    }
    
    /// Vertices contained herein.
    public let vertices: VertexCollection
    
    // MARK: - Initializers
    
    /// Creates a `Polygon` with the given `vertices`.
    public init <S: Sequence> (vertices: S) where S.Iterator.Element == Point {
        self.vertices = VertexCollection(vertices)
    }
    
    /// Create a unconstrained `Polygon` from any `PolygonProtocol`-conforming type.
    public init(_ polygon: PolygonProtocol) {
        self.vertices = polygon.vertices
    }
}

extension Polygon: Equatable {
    
    // MARK: Equatable
    
    /// - Returns: `true` if the vertices of each `Polygon` are equivalent.
    public static func == (lhs: Polygon, rhs: Polygon) -> Bool {
        return lhs.vertices == rhs.vertices
    }
}
