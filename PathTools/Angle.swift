//
//  Angle.swift
//  PathTools
//
//  Created by James Bean on 6/6/17.
//
//

public typealias Radians = Double
public typealias Degrees = Double

public struct Angle {
    
    public let degrees: Degrees
    public let radians: Radians
    
    public init(radians: Radians) {
        self.radians = radians
        self.degrees = makeDegrees(from: radians)
    }
    
    public init(degrees: Degrees) {
        self.degrees = degrees
        self.radians = makeRadians(from: degrees)
    }
}

internal func makeRadians(from degrees: Degrees) -> Radians {
    return degrees / 180.0 * .pi
}

internal func makeDegrees(from radians: Radians) -> Degrees {
    return radians * (180.0 / .pi)
}
