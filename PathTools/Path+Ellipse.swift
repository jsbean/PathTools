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
    
    public init(_ ellipse: Ellipse) {
        
        let left = ellipse.center.x - 0.5 * ellipse.size.width
        let right = ellipse.center.x + 0.5 * ellipse.size.width
        let top = ellipse.center.y + 0.5 * ellipse.size.height
        let bottom = ellipse.center.y - 0.5 * ellipse.size.height
        
        let (x,y) = (ellipse.center.x, ellipse.center.y)
        let (w,h) = (ellipse.size.width, ellipse.size.height)
        
        // Distance from each point to its neighboring control points
        let ax = (4 * (sqrt(2.0) - 1) / 3) * (w / 2)
        let ay = (4 * (sqrt(2.0) - 1) / 3) * (h / 2)
        
        let curves = [
            
            // top center -> right
            BezierCurve(
                start: Point(x: x, y: top),
                control1: Point(x: x + ax, y: top),
                control2: Point(x: right, y: y + ay),
                end: Point(x: right, y: y)
            ),
            
            // right -> bottom center
            BezierCurve(
                start: Point(x: right, y: y),
                control1: Point(x: right, y: y - ay),
                control2: Point(x: x + ax, y: bottom),
                end: Point(x: x, y: bottom)
            ),
            
            // bottom center -> left
            BezierCurve(
                start: Point(x: x, y: bottom),
                control1: Point(x: x - ax, y: bottom),
                control2: Point(x: left, y: y - ay),
                end: Point(x: left, y: y)
            ),
            
            // left -> top center
            BezierCurve(
                start: Point(x: left, y: y),
                control1: Point(x: left, y: y + ay),
                control2: Point(x: x - ax, y: top),
                end: Point(x: x, y: top)
            )
        ]
        
        self.init(curves)
    }

    /// - returns: `Path` with an ellipse shape within the given `rectangle`.
    public static func ellipse(in rect: Rectangle) -> Path {
        return Path(Ellipse(center: Point(x: rect.midX, y: rect.midY), size: rect.size))
    }
}
