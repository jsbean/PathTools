//
//  Path+Ellipse.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import QuartzCore
import GeometryTools

extension Path {
    
    // MARK: - Ellipse

    /// - returns: `Path` with an ellipse shape within the given `rectangle`.
    ///
    /// - TODO: Implement arcs properly.
    public static func ellipse(in rect: Rectangle) -> Path {
        return Path(CGPath(ellipseIn: CGRect(rect), transform: nil))
    }
}
