//
//  Path+Arrowhead.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import QuartzCore

extension Path {
    
    // MARK: - Arrowhead

    public static func arrowhead(
        tip: Point = Point(),
        height: Double = 100,
        width: Double = 25,
        barbProportion: Double = 0.25,
        rotation: Degrees = 0
    ) -> Path
    {
        let path = Path(
            [
                .move(Point(x: 0.5 * width, y: 0)),
                .line(Point(x: width, y: height)),
                .line(Point(x: 0.5 * width, y: height - (barbProportion * height))),
                .line(Point(x: 0, y: height)),
                .close
            ]
        )
        if rotation == 0 { return path }
        return path.rotated(by: rotation)
    }
}
