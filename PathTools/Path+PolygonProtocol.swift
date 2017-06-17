//
//  Path+PolygonProtocol.swift
//  PathTools
//
//  Created by James Bean on 6/17/17.
//
//

import GeometryTools

extension Path {
    
    /// Creates a `Path` with the given `polygon`.
    public init <P: PolygonProtocol> (_ polygon: P) {
        self.init(polygon.edges.map(BezierCurve.init))
    }
}
