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
    
    fileprivate var elements: [PathElement] = []
    
    // MARK: - Instance Properties
    
    /*
     `CGPath` representation of `Path`.
    
     > Use this as the `path` property for a `CAShapeLayer`.
    */
    public lazy var cgPath: CGPath = {
        let path = CGMutablePath()
        for element in self.elements {
            switch element {
            case .move(let point):
                path.move(to: point)
            case .line(let point):
                path.addLine(to: point)
            case .quadCurve(let point, let controlPoint):
                path.addQuadCurve(to: point, control: controlPoint)
            case .curve(let point, let controlPoint1, let controlPoint2):
                path.addCurve(to: point, control1: controlPoint1, control2: controlPoint2)
            case .close:
                path.closeSubpath()
            }
        }
        return path.copy()!
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
        withUnsafeMutablePointer(to: &pathElements) { elementsPointer in
            cgPath?.apply(info: elementsPointer) { (userInfo, nextElementPointer) in
                let nextElement = PathElement(element: nextElementPointer.pointee)
                let elementsPointer = userInfo!.assumingMemoryBound(to: [PathElement].self)
                elementsPointer.pointee.append(nextElement)
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
    public func append(_ path: Path) -> Path {
        elements.append(contentsOf: path.elements)
        return self
    }
}

/**
 - returns: New `Path` with elements of two paths.
 */
public func + (lhs: Path, rhs: Path) -> Path {
    return Path(lhs.elements + rhs.elements)
}

extension Path: Collection {
    
    // MARK: - CollectionType
    
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return elements.count }
    
    public func index(after i: Int) -> Int {
        guard i != endIndex else { fatalError("Cannot increment endIndex") }
        return i + 1
    }
    
    public subscript(index: Int) -> PathElement {
        return elements[index]
    }
}

extension Path: Sequence {
    
    // MARK: - SequenceType
    
    public func makeIterator() -> AnyIterator<PathElement> {
        var generator = elements.makeIterator()
        return AnyIterator { generator.next() }
    }
}
