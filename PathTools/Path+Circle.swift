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
    public static func circle(center: Point, radius: Double) -> Path {
        
        // distance from each point to its neighboring control points
        let a = 4 * (sqrt(2.0) - 1) / 3
        
        let elements: [PathElement] = [
            
            // top
            .move(Point(x: center.x, y: center.y - radius)),
            
            // right
            .curve(
                Point(x: center.x + radius, y: center.y),
                Point(x: center.x + a * radius, y: center.y - radius),
                Point(x: center.x + radius, y: center.y - a * radius)
            ),
            
            // bottom
            .curve(
                Point(x: center.x, y: center.y + radius),
                Point(x: center.x + radius, y: center.y + a * radius),
                Point(x: center.x + a * radius, y: center.y + radius)
            ),
            
            // left
            .curve(
                Point(x: center.x - radius, y: center.y),
                Point(x: center.x - a * radius, y: center.y + radius),
                Point(x: center.x - radius, y: center.y + a * radius)
            ),
            
            // back to top
            .curve(
                Point(x: center.x, y: center.y - radius),
                Point(x: center.x - radius, y: center.y - a * radius),
                Point(x: center.x - a * radius, y: center.y - radius)
            )
        ]
        
        return Path(elements)
    }
}
