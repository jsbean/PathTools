//
//  PathElement.swift
//  PathTools
//
//  Created by James Bean on 6/10/16.
//
//

import QuartzCore

/// Wrapper for `CGPath` `PathElement.type`.
///
/// - TODO: Generalize to `Double`
public enum PathElement {
    
    /// Move to point.
    case move(Point)

    /// Add line to point.
    case line(Point)

    /// Add quadratic bézier curve to point, with control point.
    case quadCurve(Point, Point)
    
    /// Add cubic bézier curve to point, with two control points.
    case curve(Point, Point, Point)
    
    /// Close subpath.
    case close
}

extension PathElement: CustomStringConvertible {
    
    public var description: String {
        
        switch self {        
        case .move(let point):
            return "move \(point.x),\(point.y)"
        case .line(let point):
            return "  -> \(point.x),\(point.y)"
        case .quadCurve(let point, let controlPoint):
            return "  ~> \(point.x),\(point.y) via \(controlPoint.x),\(controlPoint.y)"
        case .curve(let point, let controlPoint1, let controlPoint2):
            return "  ~> \(point.x),\(point.y) via \(controlPoint1.x),\(controlPoint1.y) & \(controlPoint2.x),\(controlPoint2.y)"
        case .close:
            return "close"
        }
    }
}
