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
    func addQuadCurve(_ curve: QuadraticBezierCurve) -> AllowingAllPathElements
    func addCurve(_ curve: CubicBezierCurve) -> AllowingAllPathElements
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
        
        /// Adds the given `curve` to the `Path` being built.
        ///
        /// - Returns: `self`.
        @discardableResult
        func addQuadCurve(_ curve: QuadraticBezierCurve) -> AllowingAllPathElements {

            if let lastPoint = elements.last?.point, lastPoint == curve.start {
                return addQuadCurve(to: curve.end, control: curve.control)
            }
            
            move(to: curve.start)
            return addQuadCurve(to: curve.end, control: curve.control)
        }
        
        /// Adds the given `curve` to the `Path` being built.
        ///
        /// - Returns: `self`.
        @discardableResult
        func addCurve(_ curve: CubicBezierCurve) -> AllowingAllPathElements {
            
            if let lastPoint = elements.last?.point, lastPoint == curve.start {
                return addCurve(
                    to: curve.end,
                    control1: curve.control1,
                    control2: curve.control2
                )
            }
            
            move(to: curve.start)
            return addCurve(to: curve.end, control1: curve.control1, control2: curve.control2)
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
