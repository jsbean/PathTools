//
//  Path+Polyline.swift
//  PathTools
//
//  Created by James Bean on 6/17/17.
//
//

import GeometryTools

extension Polyline: PathRepresentable {
    public var path: Path {
        return Path(
            points.adjacentPairs().map { start, end in BezierCurve(start: start, end: end) }
        )
    }
}
