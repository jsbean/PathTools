//
//  Degrees.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import QuartzCore

/// - TODO: Make FloatLiteralConvertible, RadianConvertible
public typealias Degrees = CGFloat

/**
 - TODO: Refactor as inits to and from degrees / radians
 */
internal func DEGREES_TO_RADIANS(_ degrees: CGFloat) -> CGFloat {
    return degrees / 180.0 * CGFloat(M_PI)
}

/**
 - TODO: Refactor as inits to and from degrees / radians
 */
internal func RADIANS_TO_DEGREES(_ radians: CGFloat) -> CGFloat {
    return radians * (180.0 / CGFloat(M_PI))
}
