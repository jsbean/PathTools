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
    
    // MARK: - Type Properties
    
    /// - Returns: `Builder` object that only exposes the `move(to:)` method, as it is a
    /// required first element for a `Path`.
    public static var builder: AllowingMoveTo {
        return Builder()
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

extension Path {

    /// - Returns: New `Path` with elements of two paths.
    public static func + (lhs: Path, rhs: Path) -> Path {
        return Path(lhs.elements + rhs.elements)
    }
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
    
    /// Printed description.
    public var description: String {
        return elements.map { "\($0)" }.joined(separator: "\n")
    }
}

extension Array {
    
    public func appending(contentsOf other: Array) -> Array {
        return self + other
    }
}
