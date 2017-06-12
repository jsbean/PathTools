//
//  Path+Circle.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import Darwin
import GeometryTools

extension Path {
    
    // MARK: - Circle
    
    /// - returns: `Path` with a circle shape with the given `radius` and `center`.
    public static func circle(center: Point, radius r: Double) -> Path {
        
        let (x,y) = (center.x, center.y)
        let left = x - r
        let right = x + r
        let top = y + r
        let bottom = y - r
        
        // Distance from each point to its neighboring control points
        let a = (4 * (sqrt(2.0) - 1) / 3) * r
        
        return Path([
            
            // top center -> right
            .cubic(
                CubicBezierCurve(
                    start: Point(x: x, y: top),
                    control1: Point(x: x + a, y: top),
                    control2: Point(x: right, y: y + a),
                    end: Point(x: right, y: y)
                )
            ),
            
            // right -> bottom center
            .cubic(
                CubicBezierCurve(
                    start: Point(x: right, y: y),
                    control1: Point(x: right, y: y - a),
                    control2: Point(x: x + a, y: bottom),
                    end: Point(x: x, y: bottom)
                )
            ),
            
            // bottom center -> left
            .cubic(
                CubicBezierCurve(
                    start: Point(x: x, y: bottom),
                    control1: Point(x: x - a, y: bottom),
                    control2: Point(x: left, y: y - a),
                    end: Point(x: left, y: y)
                )
            ),
            
            // left -> top center
            .cubic(
                CubicBezierCurve(
                    start: Point(x: left, y: y),
                    control1: Point(x: left, y: y + a),
                    control2: Point(x: x - a, y: top),
                    end: Point(x: x, y: top)
                )
            )
            
        ])
    }
}
