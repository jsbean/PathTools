//
//  Path.swift
//  PathTools
//
//  Created by James Bean on 6/10/16.
//
//

import Collections
import ArithmeticTools
import GeometryTools

public class Path {
    
    // MARK: - Instance Properties
    
    public var isShape: Bool {
        return elements.allSatisfy { $0.isVertex }
    }
    
    /// - Returns: `true` if there are no non-`.close` elements contained herein. Otherwise,
    /// `false`.
    public var isEmpty: Bool {
        return elements.filter { $0 != .close }.isEmpty
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

extension Path: Equatable {
    
    public static func == (lhs: Path, rhs: Path) -> Bool {
        return lhs.elements == rhs.elements
    }
}

extension Path: CustomStringConvertible {
    
    // MARK: - `CustomStringConvertible`
    
    public var description: String {
        return elements.map { "\($0)" }.joined(separator: "\n")
    }
}
