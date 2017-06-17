//
//  Path+Line.swift
//  PathTools
//
//  Created by James Bean on 6/17/17.
//
//

import GeometryTools

extension Path {
 
    /// Creates a `Path` with the given `line`.
    public init(_ line: Line) {
        self.init([BezierCurve(line)])
    }
}
