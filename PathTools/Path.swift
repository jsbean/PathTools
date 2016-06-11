//
//  Path.swift
//  PathTools
//
//  Created by James Bean on 6/10/16.
//
//

import QuartzCore

public final class Path {
    
    private var elements: [PathElement] = []
    
    public lazy var cgPath: CGPath? = {
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
        return CGPathCreateCopy(path)
    }()
    
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
        self.cgPath = cgPath
        self.elements = pathElements
    }

    public init(_ elements: [PathElement]) {
        self.elements = elements
    }
    
    public func move(to point: CGPoint) {
        elements.append(.move(point))
    }
    
    public func addLine(to point: CGPoint) {
        elements.append(.line(point))
    }
    
    public func addQuadCurve(to point: CGPoint, controlPoint: CGPoint) {
        elements.append(.quadCurve(point, controlPoint))
    }
    
    public func addCurve(
        to point: CGPoint,
        controlPoint1: CGPoint,
        controlPoint2: CGPoint
    )
    {
        elements.append(.curve(point, controlPoint1, controlPoint2))
    }
    
    public func close() {
        elements.append(.close)
    }
}

extension Path: CollectionType {
    
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return elements.count }
    
    public subscript(index: Int) -> PathElement {
        return elements[index]
    }
}

extension Path: SequenceType {
    
    public func generate() -> AnyGenerator<PathElement> {
        var generator = elements.generate()
        return AnyGenerator { generator.next() }
    }
}