//
//  Path+Ellipse.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import QuartzCore

extension Path {
    
    // MARK: - Ellipse
    
    /**
     - returns: `Path` with an ellipse shape within the given `rectangle`.
     */
    public static func ellipse(rectangle: CGRect) -> Path {
        return Path(CGPath(ellipseIn: rectangle, transform: nil))
    }
    
    // TODO: static func ellipse(center, width, height) -> Path
}
