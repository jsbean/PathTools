//
//  Path+Rectangle.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import QuartzCore

extension Path {
    
    // MARK: - Rectangle
    
    /// - returns: `Path` with a rectangle shape defined by `rectangle`.
    public static func rectangle(_ rect: Rectangle) -> Path {
        return Path()
            .move(to: rect.origin)
            .addLine(to: Point(x: rect.maxX, y: rect.minY))
            .addLine(to: Point(x: rect.maxX, y: rect.maxY))
            .addLine(to: Point(x: rect.minX, y: rect.maxY))
            .close()
    }
}
