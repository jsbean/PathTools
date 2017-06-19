//
//  Path+Line.Segment.swift
//  PathTools
//
//  Created by James Bean on 6/17/17.
//
//

import GeometryTools

extension Line.Segment: PathRepresentable {
    public var path: Path {
        return Path([BezierCurve(self)])
    }
}
