//
//  Point.swift
//  PathTools
//
//  Created by James Bean on 1/7/17.
//
//

/// Representation of a point.
///
/// - TODO: Consider making generic over `SignedNumber`.
public struct Point {
    
    public let x: Double
    public let y: Double
    
    public init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }
}

extension Point {
    
    // MARK: - `Equatable`
    
    public static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
