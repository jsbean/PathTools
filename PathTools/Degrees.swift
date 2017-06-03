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

internal func radians(from degrees: Degrees) -> Radians {
    return degrees / 180.0 * .pi
}

internal func degrees(from radians: Radians) -> Degrees {
    return radians * (180.0 / .pi)
}
