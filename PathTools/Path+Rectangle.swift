//
//  Path+Rectangle.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import GeometryTools

extension Path {
    
    // MARK: - Rectangle
    
    /// Creates a `Path` with the given `rectangle`.
    public init(_ rectangle: Rectangle) {
        self.init(rectangle.edges.map(BezierCurve.init))
    }
    
    /// - Returns: `Path` with a rectangle shape defined by `rectangle`.
    public static func rectangle(_ rect: Rectangle) -> Path {
        return Path(rect)
    }

    /// - Returns: `Path` with a rectangle shape with the given `origin` and `size`.
    public static func rectangle(origin: Point, size: Size) -> Path {
        return Path(Rectangle(origin: origin, size: size))
    }
    
    /// - Returns: `Path` with a rectangle shape with the given `x`, `y`, `width`, and `height`
    /// values.
    public static func rectangle(x: Double, y: Double, width: Double, height: Double)
        -> Path
    {
        return Path(Rectangle(x: x, y: y, width: width, height: height))
    }
}
