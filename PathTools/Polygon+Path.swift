//
//  Polygon+Path.swift
//  PathTools
//
//  Created by James Bean on 6/6/17.
//
//

extension Polygon {

    /// Creates a `Polygon` with the given `path`.
    ///
    /// - Throws: `PolygonError` if there are not at least three vertices.
    ///
    public init(_ path: Path) throws {
        
        // Strip out Bézier curve information, and leave only end points.
        let vertices = path.elements.flatMap { $0.point }
        
        guard vertices.count >= 3 else {
            
            throw PolygonError.invalidVertices(
                VertexCollection(vertices),
                Polygon.self,
                "A Polygon must have at least three vertices!"
            )
        }
        
        self.init(vertices: vertices)
    }
}
