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
    public var cgPath: CGPath {
        
        let path = CGMutablePath()
        
        guard let (head, tail) = curves.destructured else {
            return path
        }
        
        path.move(to: CGPoint(head.start))
        
        for curve in tail {
            switch curve.points.count {
            case 2:
                path.addLine(to: CGPoint(curve.points[1]))
            case 3:
                path.addQuadCurve(to: CGPoint(curve.end), control: CGPoint(curve.points[1]))
            case 4:
                path.addCurve(
                    to: CGPoint(curve.end),
                    control1: CGPoint(curve.points[1]),
                    control2: CGPoint(curve.points[2])
                )
            default:
                fatalError(
                    "Bézier curves with \(curve.points.count) control points not supported!"
                )
            }
            
//            switch curve {
//            case let .linear(linear):
//                path.addLine(to: CGPoint(linear.end))
//            case let .quadratic(quadratic):
//                path.addQuadCurve(
//                    to: CGPoint(quadratic.end),
//                    control: CGPoint(quadratic.control)
//                )
//            case let .cubic(cubic):
//                path.addCurve(
//                    to: CGPoint(cubic.end),
//                    control1: CGPoint(cubic.control1),
//                    control2: CGPoint(cubic.control2)
//                )
//            }
        }
        
        return path.copy()!
    }
    
    /// Creates a `Path` with a `CGPath`.
    public init(_ cgPath: CGPath?) {
        var pathElements: [PathElement] = []
        withUnsafeMutablePointer(to: &pathElements) { elementsPointer in
            cgPath?.apply(info: elementsPointer) { (userInfo, nextElementPointer) in
                let nextElement = PathElement(element: nextElementPointer.pointee)
                let elementsPointer = userInfo!.assumingMemoryBound(to: [PathElement].self)
                elementsPointer.pointee.append(nextElement)
            }
        }
        self.init(pathElements: pathElements)
    }
}
