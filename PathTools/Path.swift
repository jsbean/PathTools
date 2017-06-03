//
//  Path.swift
//  PathTools
//
//  Created by James Bean on 6/10/16.
//
//

import Collections
import ArithmeticTools

/// Pleasant graphics API that is compatible with iOS and OSX.
public class Path {
    
    // MARK: - Instance Properties
    
    public var vertices: [Point] {
        return elements.flatMap { element in
            switch element {
            case .move(let point), .line(let point):
                return point
            case .curve(let point, _, _), .quadCurve(let point, _):
                return point
            case .close:
                return nil
            }
        }
    }
    
    internal var elements: [PathElement] = []
        
    // MARK: - Initializers
    
    /// Creates an empty `Path`.
    public init() { }
    
    /// Create a `Path` with an array of `PathElement` values.
    public init(_ elements: [PathElement]) {
        self.elements = elements
    }
    
    // MARK: - Instance Methods
    
    /// Move to `point`.
    ///
    /// - returns: `self`
    @discardableResult
    public func move(to point: Point) -> Path {
        elements.append(.move(point))
        return self
    }
    
    /// Add line to `point`.
    ///
    /// - returns: `self`.
    @discardableResult
    public func addLine(to point: Point) -> Path {
        elements.append(.line(point))
        return self
    }
    
    /// Add curve to `point`, with a single control point.
    ///
    /// - returns: `self`.
    @discardableResult
    public func addQuadCurve(to point: Point, controlPoint: Point) -> Path {
        elements.append(.quadCurve(point, controlPoint))
        return self
    }

    /// Add curve to `point`, with two control points.
    ///
    /// - returns: `self`.
    @discardableResult
    public func addCurve(
        to point: Point,
        controlPoint1: Point,
        controlPoint2: Point
    ) -> Path
    {
        elements.append(.curve(point, controlPoint1, controlPoint2))
        return self
    }
    
    /// Close path.
    ///
    /// - returns: `self`.
    @discardableResult
    public func close() -> Path {
        elements.append(.close)
        return self
    }
    
    /// Append the elements of another `Path` to this one.
    ///
    /// - returns: `self`.
    @discardableResult
    public func append(_ path: Path) -> Path {
        elements.append(contentsOf: path.elements)
        return self
    }
}

/// - returns: New `Path` with elements of two paths.
public func + (lhs: Path, rhs: Path) -> Path {
    return Path(lhs.elements + rhs.elements)
}

extension Path: AnyCollectionWrapping {

    // MARK: - `AnyCollectionWrapping`
    
    public var collection: AnyCollection<PathElement> {
        return AnyCollection(elements)
    }
}

extension Path: CustomStringConvertible {
    
    // MARK: - `CustomStringConvertible`
    
    public var description: String {
        return elements.map { "\($0)" }.joined(separator: "\n")
    }
}
