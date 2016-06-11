//
//  PathElement.swift
//  PathTools
//
//  Created by James Bean on 6/10/16.
//
//

import QuartzCore

public enum PathElement {
    case move(CGPoint)
    case line(CGPoint)
    case quadCurve(CGPoint, CGPoint)
    case curve(CGPoint, CGPoint, CGPoint)
    case close
    
    public init(element: CGPathElement) {
        switch element.type {
        case .MoveToPoint:
            self = .move(element.points[0])
        case .AddLineToPoint:
            self = .line(element.points[0])
        case .AddQuadCurveToPoint:
            self = .quadCurve(element.points[0], element.points[1])
        case .AddCurveToPoint:
            self = .curve(element.points[0], element.points[1], element.points[2])
        case .CloseSubpath:
            self = .close
        }
    }
}
