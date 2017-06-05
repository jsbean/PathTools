//
//  Path+Polygon.swift
//  PathTools
//
//  Created by James Bean on 6/5/17.
//
//

import Collections

public class Polygon: Path {
    
    // MARK: - Instance Properties
    
    /// - Returns: Edges of `Polygon`.
    public var edges: [(Point, Point)] {
        return vertices.adjacentPairs(wrapped: true)
    }
    
    /// - Returns: All vertices of `Polygon`.
    public var vertices: [Point] {
        return elements.flatMap { element in
            switch element {
            case .move(let point), .line(let point):
                return point
            case .close:
                return nil
            default:
                fatalError("There is way that there could be curves here!")
            }
        }
    }
    
    /// - Returns: `true` if `Polygon` is convex. Otherwise, `false`.
    public var isConvex: Bool {
        fatalError()
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
