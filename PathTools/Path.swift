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

/// - TODO: Conform to `Collection` protocols (parameterized over `BezierCurve`)
public struct Path {
    
    // MARK: - Type Properties
    
    /// - Returns: `Builder` object that only exposes the `move(to:)` method, as it is a
    /// required first element for a `Path`.
    public static var builder: AllowingMoveTo {
        return Builder()
    }
    
    // MARK: - Instance Properties
    
    public var isShape: Bool {
        return curves.all { curve in
            switch curve {
            case .linear:
                return true
            default:
                return false
            }
        }
    }
    
    /// - Returns: `true` if there are no non-`.close` elements contained herein. Otherwise,
    /// `false`.
    public var isEmpty: Bool {
        return curves.isEmpty
    }
    
    internal let curves: [BezierCurve]
    
    public init(_ curves: [BezierCurve]) {
        self.curves = curves
    }
    
    internal init(pathElements: [PathElement]) {
        
        guard
            let (head, tail) = pathElements.destructured, case let .move(start) = head
        else {
            self = Path([])
            return
        }
        
        let builder = Path.builder.move(to: start)
        
        for element in tail {
            switch element {
            case .move(let point):
                builder.move(to: point)
            case .line(let point):
                builder.addLine(to: point)
            case .quadCurve(let point, let control):
                builder.addQuadCurve(to: point, control: control)
            case .curve(let point, let control1, let control2):
                builder.addCurve(to: point, control1: control1, control2: control2)
            case .close:
                builder.close()
            }
        }
        
        self = builder.build()
    }
}

extension Path {

    /// - Returns: New `Path` with elements of two paths.
    public static func + (lhs: Path, rhs: Path) -> Path {
        fatalError()
        //return Path(lhs.elements + rhs.elements)
    }
}

extension Path: AnyCollectionWrapping {

    // MARK: - `AnyCollectionWrapping`
    
    public var collection: AnyCollection<BezierCurve> {
        return AnyCollection(curves)
    }
}

extension Path: Equatable {
    
    public static func == (lhs: Path, rhs: Path) -> Bool {
        return lhs.curves == rhs.curves
    }
}

extension Path: CustomStringConvertible {
    
    // MARK: - `CustomStringConvertible`
    
    /// Printed description.
    public var description: String {
        return curves.map { "\($0)" }.joined(separator: "\n")
    }
}

extension Array {
    
    public func appending(contentsOf other: Array) -> Array {
        return self + other
    }
}
