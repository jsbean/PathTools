//
//  Path.swift
//  PathTools
//
//  Created by James Bean on 6/10/16.
//
//

import QuartzCore

/**
 Pleasant graphics API that is compatible with iOS and OSX. Wraps CGPath.
 
 Exposes CGPath path elements, which is useful for:
    
 - Bézier path calculations
 - Polygonal collision testing
 */
public final class Path {
    
    private var elements: [PathElement] = []
    
    // MARK: - Instance Properties
    
    /*
     `CGPath` representation of `Path`.
    
     > Use this as the `path` property for a `CAShapeLayer`.
    */
    public lazy var cgPath: CGPath = {
        let path = CGPathCreateMutable()
        for element in self.elements {
            switch element {
            case .move(let point):
                CGPathMoveToPoint(path, nil, point.x, point.y)
            case .line(let point):
                CGPathAddLineToPoint(path, nil, point.x, point.y)
            case .quadCurve(let point, let controlPoint):
                CGPathAddQuadCurveToPoint(
                    path, nil,
                    controlPoint.x, controlPoint.y,
                    point.x, point.y
                )
            case .curve(let point, let controlPoint1, let controlPoint2):
                CGPathAddCurveToPoint(
                    path, nil,
                    controlPoint1.x, controlPoint1.y,
                    controlPoint2.x, controlPoint2.y,
                    point.x, point.y
                )
            case .close:
                CGPathCloseSubpath(path)
            }
        }
        return CGPathCreateCopy(path)!
    }()
    
    // MARK: - Initializers
    
    /**
     Create an empty `Path`.
     */
    public init() { }
    
    /**
     Create a `Path` with a `CGPath`.
     */
    public init(_ cgPath: CGPath?) {
        var pathElements: [PathElement] = []
        withUnsafeMutablePointer(&pathElements) { elementsPointer in
            CGPathApply(cgPath, elementsPointer) { (userInfo, nextElementPointer) in
                let nextElement = PathElement(element: nextElementPointer.memory)
                let elementsPointer = UnsafeMutablePointer<[PathElement]>(userInfo)
                elementsPointer.memory.append(nextElement)
            }
        }
        self.cgPath = cgPath!
        self.elements = pathElements
    }

    /**
     Create a `Path` with an array of `PathElement` values.
     */
    public init(_ elements: [PathElement]) {
        self.elements = elements
    }
    
    // MARK: - Instance Methods
    
    /**
     Move to `point`.
     
     - returns: `self`.
     */
    public func move(to point: CGPoint) -> Path {
        elements.append(.move(point))
        return self
    }
    
    /**
     Add line to `point`.
     
     - returns: `self`.
     */
    public func addLine(to point: CGPoint) -> Path {
        elements.append(.line(point))
        return self
    }
    
    /**
     Add curve to `point`, with a single control point.
     
     - returns: `self`.
     */
    public func addQuadCurve(to point: CGPoint, controlPoint: CGPoint) -> Path {
        elements.append(.quadCurve(point, controlPoint))
        return self
    }
    
    /**
     Add curve to `point`, with two control points.
     
     - returns: `self`.
     */
    public func addCurve(
        to point: CGPoint,
        controlPoint1: CGPoint,
        controlPoint2: CGPoint
    ) -> Path
    {
        elements.append(.curve(point, controlPoint1, controlPoint2))
        return self
    }
    
    /**
     Close path.
     
     - returns: `self`.
     */
    public func close() -> Path {
        elements.append(.close)
        return self
    }
    
    /**
     Append the elements of another `Path` to this one.
     - returns: `self`.
     */
    public func append(path: Path) -> Path {
        elements.appendContentsOf(path.elements)
        return self
    }
}

/**
 - returns: New `Path` with elements of two paths.
 */
public func + (lhs: Path, rhs: Path) -> Path {
    return Path(lhs.elements + rhs.elements)
}

extension Path: CollectionType {
    
    // MARK: - CollectionType
    
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return elements.count }
    
    public subscript(index: Int) -> PathElement {
        return elements[index]
    }
}

extension Path: SequenceType {
    
    // MARK: - SequenceType
    
    public func generate() -> AnyGenerator<PathElement> {
        var generator = elements.generate()
        return AnyGenerator { generator.next() }
    }
}