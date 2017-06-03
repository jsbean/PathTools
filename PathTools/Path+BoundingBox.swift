//
//  Path+BoundingBox.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import QuartzCore

extension Path {
    
    /// - warning: Not yet implemented!
    public var boundingBox: Path {
        return Path.rectangle(Rectangle(cgPath.boundingBoxOfPath))
    }
}
