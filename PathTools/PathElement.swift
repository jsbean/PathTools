//
//  PathElement.swift
//  PathTools
//
//  Created by James Bean on 6/10/16.
//
//

import QuartzCore

/**
 Wrapper for `CGPath` `PathElement.type`.
 */
public enum PathElement {
    
    /**
     Move to point.
     */
    case move(CGPoint)
    
    /**
     Add line to point.
     */
    case line(CGPoint)
    
    /**
     Add quadratic bézier curve to point, with control point.
     */
    case quadCurve(CGPoint, CGPoint)
    
    /**
     Add cubic bézier curve to point, with two control points.
     */
    case curve(CGPoint, CGPoint, CGPoint)
    
    /**
     Close subpath.
     */
    case close
    
    /**
     Create a `PathElement` with a `CGPathElement`.
     */
    public init(element: CGPathElement) {
        switch element.type {
        case .moveToPoint:
            self = .move(element.points[0])
        case .addLineToPoint:
            self = .line(element.points[0])
        case .addQuadCurveToPoint:
            self = .quadCurve(element.points[0], element.points[1])
        case .addCurveToPoint:
            self = .curve(element.points[0], element.points[1], element.points[2])
        case .closeSubpath:
            self = .close
        }
    }
}
