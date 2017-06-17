//
//  Path+Polyline.swift
//  PathTools
//
//  Created by James Bean on 6/17/17.
//
//

import GeometryTools

extension Path {
    
    public init(_ polyline: Polyline) {
        
        let curves = polyline.points.adjacentPairs().map { start, end in
            BezierCurve(start: start, end: end)
        }
        
        self.init(curves)
    }
}
