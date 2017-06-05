//
//  Polygon.swift
//  PathTools
//
//  Created by James Bean on 6/5/17.
//
//

import Collections
import ArithmeticTools

public class Polygon: Path {
    
    // MARK: - Instance Properties
    
    /// - TODO: Move to `dn-m/Collections`.
    public var adjacentTriplets: [(Point, Point, Point)] {
        return (0 ..< vertices.count).map { i in
            let a = vertices[i]
            let b = vertices[(i + 1) % vertices.count]
            let c = vertices[(i + 2) % vertices.count]
            return (a,b,c)
        }
    }
    
    /// - Returns: Edges of `Polygon`.
    public var edges: [(Point, Point)] {
        return vertices.adjacentPairs(wrapped: true)
    }
    
    /// - Returns: All vertices of `Polygon`.
    public lazy var vertices: [Point] = {
        return self.elements.flatMap { element in
            switch element {
            case .move(let point), .line(let point):
                return point
            case .close:
                return nil
            default:
                fatalError("There is way that there could be curves here!")
            }
        }
    }()
    
    /// - Returns: `true` if `Polygon` is convex. Otherwise, `false`.
    public var isConvex: Bool {
        
        func zCrossProduct(_ a: Point, _ b: Point, _ c: Point) -> Double {
            return (a.x - b.x) * (b.y - c.y) - (a.y - b.y) * (b.x - c.x)
        }

        return adjacentTriplets.map(zCrossProduct).map { $0.sign }.isHomogeneous
    }
    
    // MARK: - Initializers
    
    /// Creates a `Polygon` with the given `vertices`.
    ///
    /// - Warning: Will crash if given less than vertices.
    public init(vertices: [Point]) {
        
        guard vertices.count >= 3 else {
            fatalError("Cannot create a polygon without at least three vertices!")
        }
        
        let (first, rest) = vertices.destructured!
        super.init([.move(first)] + rest.map { .line($0) } + PathElement.close)
    }
    
    /// Creates a `Polygon` with the given `path`.
    ///
    /// - Returns: `nil` if there are less than three vertices.
    public convenience init?(_ path: Path) {
        
        let vertices = path.elements.flatMap { $0.point }
        
        guard vertices.count >= 3 else {
            return nil
        }
        
        self.init(vertices: vertices)
    }
}
