//
//  Path+Circle.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import QuartzCore

extension Path {
    
    public static func circle(center center: CGPoint, radius: CGFloat) -> Path {
        return Path(
            [
                .move(CGPoint(x: center.x, y: center.y - radius)),
                .quadCurve(
                    CGPoint(x: center.x + radius, y: center.y),
                    CGPoint(x: center.x + radius, y: center.y - radius)
                ),
                .quadCurve(
                    CGPoint(x: center.x, y: center.y + radius),
                    CGPoint(x: center.x + radius, y: center.y + radius)
                ),
                .quadCurve(
                    CGPoint(x: center.x - radius, y: center.y),
                    CGPoint(x: center.x - radius, y: center.y + radius)
                ),
                .quadCurve(
                    CGPoint(x: center.x, y: center.y - radius),
                    CGPoint(x: center.x - radius, y: center.y - radius)
                )
            ]
        )
    }
}
