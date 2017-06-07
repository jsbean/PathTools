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
    
    /// - Returns: `Path` with a rectangle shape defined by `rectangle`.
    public static func rectangle(_ rect: Rectangle) -> Path {
        return Path()
            .move(to: rect.origin)
            .addLine(to: Point(x: rect.maxX, y: rect.minY))
            .addLine(to: Point(x: rect.maxX, y: rect.maxY))
            .addLine(to: Point(x: rect.minX, y: rect.maxY))
            .close()
    }

    /// - Returns: `Path` with a rectangle shape with the given `origin` and `size`.
    public static func rectangle(origin: Point, size: Size) -> Path {
        let rect = Rectangle(origin: origin, size: size)
        return rectangle(rect)
    }
    
    /// - Returns: `Path` with a rectangle shape with the given `x`, `y`, `width`, and `height`
    /// values.
    public static func rectangle(x: Double, y: Double, width: Double, height: Double)
        -> Path
    {
        let rect = Rectangle(x: x, y: y, width: width, height: height)
        return rectangle(rect)
    }
}
