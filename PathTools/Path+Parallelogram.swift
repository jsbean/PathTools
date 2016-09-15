//
//  Path+Parallelogram.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import QuartzCore

extension Path {
    
    // MARK: - Parallelogram
    
    /**
     - returns: `Path` of a slanted bar.
     
     - note: The sides are always vertical, independant of the slope.
     
     - note: Useful for accidental components and system dividers.
     */
    public static func parallelogram(
        center: CGPoint,
        height: CGFloat,
        width: CGFloat,
        slope: CGFloat
    ) -> Path
    {
        let left: CGFloat = center.x - 0.5 * width
        let right: CGFloat = left + width
        func y(at x: CGFloat) -> CGFloat { return center.y - slope * (x - 0.5 * width) }
        
        let y_topLeft: CGFloat = y(at: left) - 0.5 * height
        let y_topRight: CGFloat = y(at: right) - 0.5 * height
        let y_bottomRight: CGFloat = y(at: right) + 0.5 * height
        let y_bottomLeft: CGFloat = y(at: left) + 0.5 * height
        
        return Path(
             [
                .move(CGPoint(x: left, y: y_topLeft)),
                .line(CGPoint(x: right, y: y_topRight)),
                .line(CGPoint(x: right, y: y_bottomRight)),
                .line(CGPoint(x: left, y: y_bottomLeft)),
                .close
            ]
        )
    }
}
