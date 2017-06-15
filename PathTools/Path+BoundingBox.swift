//
//  Path+BoundingBox.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import QuartzCore
import GeometryTools

extension Path {
    
    /// - TODO: Remove Quartz dependency.
    public var boundingBox: Rectangle {
        return Rectangle(cgPath.boundingBox)
    }
}
