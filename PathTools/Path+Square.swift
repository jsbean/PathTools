//
//  Path+Square.swift
//  PathTools
//
//  Created by James Bean on 6/13/16.
//
//

import GeometryTools

extension Path {
    
    // MARK: - Square
    
    public static func square(center: Point, width: Double) -> Path {
        let origin = Point(x: center.x - 0.5 * width, y: center.y - 0.5 * width)
        let builder = Path.Builder()
            .move(to: origin)
            .addLine(to: Point(x: origin.x + width, y: origin.y))
            .addLine(to: Point(x: origin.x + width, y: origin.y + width))
            .addLine(to: Point(x: origin.x, y: origin.y + width))
            .close()
        return builder.build()
    }
}
