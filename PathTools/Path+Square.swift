//
//  Path+Square.swift
//  PathTools
//
//  Created by James Bean on 6/13/16.
//
//

import QuartzCore

extension Path {
    
    // MARK: - Square
    
    public static func square(center: CGPoint, width: CGFloat) -> Path {
        let origin = CGPoint(x: center.x - 0.5 * width, y: center.y - 0.5 * width)
        return Path()
            .move(to: origin)
            .addLine(to: CGPoint(x: origin.x + width, y: origin.y))
            .addLine(to: CGPoint(x: origin.x + width, y: origin.y + width))
            .addLine(to: CGPoint(x: origin.x, y: origin.y + width))
            .close()
    }
}
