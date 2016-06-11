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
    
    /**
     - returns: `Path` with a rectangle shape defined by `rectangle`.
     */
    public static func rectangle(rectangle rectangle: CGRect) -> Path {
        return Path(
            [
                .move(rectangle.origin),
                .line(CGPoint(x: rectangle.maxX, y: rectangle.minY)),
                .line(CGPoint(x: rectangle.maxX, y: rectangle.maxY)),
                .line(CGPoint(x: rectangle.minX, y: rectangle.maxY)),
                .close
            ]
        )
    }
}
