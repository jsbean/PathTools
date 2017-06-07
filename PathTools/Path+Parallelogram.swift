//
//  Path+Parallelogram.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import QuartzCore
import GeometryTools

extension Path {
    
    // MARK: - Parallelogram
    
    /**
     - returns: `Path` of a slanted bar.
     
     - note: The sides are always vertical, independant of the slope.
     
     - note: Useful for accidental components and system dividers.
     */
    public static func parallelogram(
        center: Point,
        height: Double,
        width: Double,
        slope: Double
    ) -> Path
    {
        let left: Double = center.x - 0.5 * width
        let right: Double = left + width
        
        func y(at x: Double) -> Double {
            return center.y - slope * (x - 0.5 * width)
        }
        
        let y_topLeft: Double = y(at: left) - 0.5 * height
        let y_topRight: Double = y(at: right) - 0.5 * height
        let y_bottomRight: Double = y(at: right) + 0.5 * height
        let y_bottomLeft: Double = y(at: left) + 0.5 * height
        
        return Path(
             [
                .move(Point(x: left, y: y_topLeft)),
                .line(Point(x: right, y: y_topRight)),
                .line(Point(x: right, y: y_bottomRight)),
                .line(Point(x: left, y: y_bottomLeft)),
                .close
            ]
        )
    }
}
