//
//  Path+Ellipse.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import QuartzCore
import GeometryTools

extension Path {
    
    // MARK: - Ellipse

    /// - returns: `Path` with an ellipse shape within the given `rectangle`.
    ///
    /// - TODO: Implement arcs properly.
    public static func ellipse(in rect: Rectangle) -> Path {
        
        let left = rect.minX
        let right = rect.maxX
        let top = rect.maxY
        let bottom = rect.minY
        
        let (x,y) = (rect.minX, rect.maxY)
        let (w,h) = (rect.size.width, rect.size.height)
        let ax = (4 * (sqrt(2.0) - 1) / 3) * (w / 2)
        let ay = (4 * (sqrt(2.0) - 1) / 3) * (h / 2)
        
        return Path([
            
            // top center -> right
            .cubic(
                CubicBezierCurve(
                    start: Point(x: x, y: top),
                    control1: Point(x: x + ax, y: top),
                    control2: Point(x: right, y: y + ay),
                    end: Point(x: right, y: y)
                )
            ),
            
            // right -> bottom center
            .cubic(
                CubicBezierCurve(
                    start: Point(x: right, y: y),
                    control1: Point(x: right, y: y - ay),
                    control2: Point(x: x + ax, y: bottom),
                    end: Point(x: x, y: bottom)
                )
            ),
            
            // bottom center -> left
            .cubic(
                CubicBezierCurve(
                    start: Point(x: x, y: bottom),
                    control1: Point(x: x - ax, y: bottom),
                    control2: Point(x: left, y: y - ay),
                    end: Point(x: left, y: y)
                )
            ),
            
            // left -> top center
            .cubic(
                CubicBezierCurve(
                    start: Point(x: left, y: y),
                    control1: Point(x: left, y: y + ay),
                    control2: Point(x: x - ax, y: top),
                    end: Point(x: x, y: top)
                )
            )
        ])
    }
}
