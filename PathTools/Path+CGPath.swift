//
//  Path+CGPath.swift
//  PathTools
//
//  Created by James Bean on 6/3/17.
//
//

import QuartzCore

extension Path {
    
    /// `CGPath` representation of `Path`.
    ///
    /// > Use this as the `path` property for a `CAShapeLayer`.
    ///
    public var cgPath: CGPath {
        let path = CGMutablePath()
        for element in elements {
            switch element {
            case .move(let point):
                path.move(to: CGPoint(point))
            case .line(let point):
                path.addLine(to: CGPoint(point))
            case .quadCurve(let point, let controlPoint):
                path.addQuadCurve(to: CGPoint(point), control: CGPoint(controlPoint))
            case .curve(let point, let controlPoint1, let controlPoint2):
                path.addCurve(
                    to: CGPoint(point),
                    control1: CGPoint(controlPoint1),
                    control2: CGPoint(controlPoint2)
                )
            case .close:
                path.closeSubpath()
            }
        }
        return path.copy()!
    }

    
    /// Creates a `Path` with a `CGPath`.
    public convenience init(_ cgPath: CGPath?) {
        var pathElements: [PathElement] = []
        withUnsafeMutablePointer(to: &pathElements) { elementsPointer in
            cgPath?.apply(info: elementsPointer) { (userInfo, nextElementPointer) in
                let nextElement = PathElement(element: nextElementPointer.pointee)
                let elementsPointer = userInfo!.assumingMemoryBound(to: [PathElement].self)
                elementsPointer.pointee.append(nextElement)
            }
        }
        self.init(pathElements)
    }
}
