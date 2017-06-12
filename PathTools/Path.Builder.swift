//
//  Path.Builder.swift
//  PathTools
//
//  Created by James Bean on 6/11/17.
//
//

import GeometryTools

/// Interface exposed upon beginning the `Path` step-building pattern, or after a subPath has
/// been closed.
public protocol AllowingMoveTo {
    func move(to point: Point) -> AllowingAllPathElements
    func addCurve(_ curve: BezierCurve) -> AllowingAllPathElements
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
        
        var subPathFirst: Point!
        var last: Point!
        var curves: [BezierCurve] = []
        
        // MARK: - Initializers
        
        /// Creates a `Path.Builder` ready to build a `Path`.
        init() { }
        
        // MARK: - Instance Methods
        
        /// Move to `point`.
        ///
        /// - Returns: `self`.
        @discardableResult
        func move(to point: Point) -> AllowingAllPathElements {
            last = point
            subPathFirst = point
            return self
        }
        
        /// Add line to `point`.
        ///
        /// - Returns: `self`.
        @discardableResult
        func addLine(to point: Point) -> AllowingAllPathElements {
            let curve = LinearBezierCurve(start: last, end: point)
            curves.append(.linear(curve))
            return self
        }
        
        /// Add curve to `point`, with a single control point.
        ///
        /// - returns: `self`.
        @discardableResult
        func addQuadCurve(to point: Point, control: Point) -> AllowingAllPathElements {
            let curve = QuadraticBezierCurve(start: last, control: control, end: point)
            curves.append(.quadratic(curve))
            return self
        }
        
        /// Add curve to `point`, with two control points.
        ///
        /// - Returns: `self`.
        @discardableResult
        func addCurve(to point: Point, control1: Point, control2: Point)
            -> AllowingAllPathElements
        {
            let curve = CubicBezierCurve(
                start: last,
                control1: control1,
                control2: control2,
                end: point
            )
            curves.append(.cubic(curve))
            return self
        }
        
        /// Adds the given `curve` to the `Path` being built.
        ///
        /// - Returns: `self`.
        @discardableResult
        func addCurve(_ curve: BezierCurve) -> AllowingAllPathElements {
            curves.append(curve)
            return self
        }
        
        /// Close path.
        ///
        /// - returns: `self`.
        @discardableResult
        func close() -> AllowingBuild & AllowingMoveTo {
            let curve = LinearBezierCurve(start: last, end: subPathFirst)
            curves.append(.linear(curve))
            return self
        }
        
        /// - Returns: `Path` value with the elements constructed thus far.
        ///
        /// - Invariant: The first element must be a `move(Point)` element. This is ensured
        /// by the step-builder interface).
        ///
        /// - Invariant: `close` elements must be followed by a `move(Point)` element, or by
        /// a `quadCurve` or `curve` element. This is ensured by the step-builder interface.
        func build() -> Path {
            return Path(curves)
            
//            guard
//                let (head, tail) = elements.destructured, case let .move(start) = head
//            else {
//                return Path([])
//            }
//            
//            var curves: [BezierCurve] = []
//            var last = start
//            for element in tail {
//                switch element {
//                case .move(let point):
//                    last = point
//                case .line(let point):
//                    let curve = LinearBezierCurve(start: last, end: point)
//                    curves.append(curve)
//                case .quadCurve(let point, let control):
//                    let curve = QuadraticBezierCurve(start: last, control: control, end: point)
//                case .curve(let point, let control1, let control2):
//                    break
//                case .close:
//                    break
//                }
//            }
//            
//            fatalError()
//            //return Path(elements)
        }
    }
}
