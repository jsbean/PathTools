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
    
    /**
     - warning: Not yet fully implemented!
     */
    public static func arrowhead(
        tip: CGPoint = CGPoint.zero,
        height: CGFloat = 100,
        width: CGFloat = 25,
        barbProportion: CGFloat = 0.25,
        rotation: Degrees = 0
    ) -> Path
    {
        let path = Path(
            [
                .move(CGPoint(x: 0.5 * width, y: 0)),
                .line(CGPoint(x: width, y: height)),
                .line(CGPoint(x: 0.5 * width, y: height - (barbProportion * height))),
                .line(CGPoint(x: 0, y: height)),
                .close
            ]
        )
        if rotation == 0 { return path }
        return path.rotated(by: rotation)
    }
}
