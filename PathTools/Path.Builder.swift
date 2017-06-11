//
//  Path.Builder.swift
//  PathTools
//
//  Created by James Bean on 6/11/17.
//
//

import GeometryTools

/// Interface exposed upon beginning the `Path` step-building patter.
public protocol AllowingMoveTo {
    func move(to point: Point) -> AllowingAllPathElements
}

/// Interface exposed (along with `ExposesMoveTo`) after adding a `close()` element.
public protocol AllowingBuild {
    func build() -> Path
}

/// Interface exposing all possible path element build steps.
public protocol AllowingAllPathElements: AllowingMoveTo, AllowingBuild {
    func addLine(to point: Point) -> AllowingAllPathElements
    func addQuadCurve(to point: Point, control: Point) -> AllowingAllPathElements
    func addCurve(to point: Point, control1: Point, control2: Point) -> AllowingAllPathElements
    func close() -> AllowingBuild & AllowingMoveTo
}

extension Path {
    
    internal final class Builder: AllowingAllPathElements {
        
        var elements: [PathElement] = []
        
        // MARK: - Initializers
        
        /// Creates a `Path.Builder` ready to build a `Path`.
        init() { }
        
        // MARK: - Instance Methods
        
        /// Move to `point`.
        ///
        /// - returns: `self`.
        @discardableResult
        func move(to point: Point) -> AllowingAllPathElements {
            elements.append(.move(point))
            return self
        }
        
        /// Add line to `point`.
        ///
        /// - returns: `self`.
        @discardableResult
        func addLine(to point: Point) -> AllowingAllPathElements {
            elements.append(.line(point))
            return self
        }
        
        /// Add curve to `point`, with a single control point.
        ///
        /// - returns: `self`.
        @discardableResult
        func addQuadCurve(to point: Point, control: Point) -> AllowingAllPathElements {
            elements.append(.quadCurve(point, control))
            return self
        }
        
        /// Add curve to `point`, with two control points.
        ///
        /// - returns: `self`.
        @discardableResult
        func addCurve(to point: Point, control1: Point, control2: Point) -> AllowingAllPathElements {
            elements.append(.curve(point, control1, control2))
            return self
        }
        
        /// Close path.
        ///
        /// - returns: `self`.
        @discardableResult
        func close() -> AllowingBuild & AllowingMoveTo {
            elements.append(.close)
            return self
        }
        
        /// - Returns: `Path` value with the elements constructed thus far.
        func build() -> Path {
            return Path(elements)
        }
    }
}
