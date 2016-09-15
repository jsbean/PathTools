//
//  Path+Circle.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import QuartzCore

extension Path {
    
    // MARK: - Circle
    
    /**
     - returns: `Path` with a circle shape with the given `radius` and `center`.
     */
    public static func circle(center: CGPoint, radius: CGFloat) -> Path {
        
        // distance from each point to its neighboring control points
        let a = CGFloat(4 * (sqrt(2.0) - 1) / 3 )
        
        let elements: [PathElement] = [
            // top
            .move(CGPoint(x: center.x, y: center.y - radius)),
            
            // right
            .curve(
                CGPoint(x: center.x + radius, y: center.y),
                CGPoint(x: center.x + a * radius, y: center.y - radius),
                CGPoint(x: center.x + radius, y: center.y - a * radius)
            ),
            
            // bottom
            .curve(
                CGPoint(x: center.x, y: center.y + radius),
                CGPoint(x: center.x + radius, y: center.y + a * radius),
                CGPoint(x: center.x + a * radius, y: center.y + radius)
            ),
            
            // left
            .curve(
                CGPoint(x: center.x - radius, y: center.y),
                CGPoint(x: center.x - a * radius, y: center.y + radius),
                CGPoint(x: center.x - radius, y: center.y + a * radius)
            ),
            
            // back to top
            .curve(
                CGPoint(x: center.x, y: center.y - radius),
                CGPoint(x: center.x - radius, y: center.y - a * radius),
                CGPoint(x: center.x - a * radius, y: center.y - radius)
            )
        ]
        
        return Path(elements)
    }
}
