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

    /// - returns: `Path` with an ellipse shape within the given `rectangle`.
    public static func ellipse(in rect: Rectangle) -> Path {
        let cgPath = CGPath(ellipseIn: CGRect(rect), transform: nil)
        print("cg path: \(cgPath)")
        let path = Path(cgPath)
        print("path: \(path)")
        return path
    }
}
