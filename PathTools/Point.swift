//
//  Point.swift
//  PathTools
//
//  Created by James Bean on 1/7/17.
//
//

import Darwin
import ArithmeticTools

/// Representation of a point.
///
/// - TODO: Consider making `Monoid`.
public struct Point {
    
    public let x: Double
    public let y: Double
    
    public init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }
    
    public func distance(to other: Point) -> Double {
        return hypot(other.x - self.x, other.y - self.y)
    }
    
    public func translatedBy(x: Double, y: Double) -> Point {
        return Point(x: self.x + x, y: self.y + y)
    }
}

extension Point: Equatable {
    
    // MARK: - `Equatable`
    
    public static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

extension Point: CustomStringConvertible {
    
    public var description: String {
        return "(\(x),\(y))"
    }
}
