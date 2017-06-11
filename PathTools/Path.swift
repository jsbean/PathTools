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

/// - TODO: Conform to `Collection` protocols
public struct Path {
    
    // MARK: - Nested Types
    
    public final class Builder {
        
        private var elements: [PathElement] = []
        
        // MARK: - Initializers
        
        /// Creates a `Path.Builder` ready to build a `Path`.
        public init() { }
        
        // MARK: - Instance Methods
        
        /// Move to `point`.
        ///
        /// - returns: `self`
        @discardableResult
        public func move(to point: Point) -> Builder {
            elements.append(.move(point))
            return self
        }
        
        /// Add line to `point`.
        ///
        /// - returns: `self`.
        @discardableResult
        public func addLine(to point: Point) -> Builder {
            elements.append(.line(point))
            return self
        }
        
        /// Add curve to `point`, with a single control point.
        ///
        /// - returns: `self`.
        @discardableResult
        public func addQuadCurve(to point: Point, control: Point) -> Builder {
            elements.append(.quadCurve(point, control))
            return self
        }
        
        /// Add curve to `point`, with two control points.
        ///
        /// - returns: `self`.
        @discardableResult
        public func addCurve(to point: Point, control1: Point, control2: Point) -> Builder {
            elements.append(.curve(point, control1, control2))
            return self
        }
        
        /// Close path.
        ///
        /// - returns: `self`.
        @discardableResult
        public func close() -> Builder {
            elements.append(.close)
            return self
        }

        
        /// - Returns: `Path` value with the elements constructed thus far.
        public func build() -> Path {
            return Path(elements)
        }
    }
    
    // MARK: - Instance Properties
    
    public var isShape: Bool {
        return elements.all { $0.isVertex }
    }
    
    /// - Returns: `true` if there are no non-`.close` elements contained herein. Otherwise,
    /// `false`.
    public var isEmpty: Bool {
        return elements.filter { $0 != .close }.isEmpty
    }
    
    /// `PathElements` comprising `Path`.
    internal let elements: [PathElement]
        
    // MARK: - Initializers
    
    /// Create a `Path` with an array of `PathElement` values.
    public init(_ elements: [PathElement]) {
        self.elements = elements
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

extension Array {
    
    public func appending(contentsOf other: Array) -> Array {
        return self + other
    }
}
