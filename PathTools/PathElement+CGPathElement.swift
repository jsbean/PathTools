//
//  PathElement+CGPathElement.swift
//  PathTools
//
//  Created by James Bean on 1/18/17.
//
//

import QuartzCore

extension PathElement {
    
    /// Create a `PathElement` with a `CGPathElement`.
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
