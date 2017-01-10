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
    
    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

extension Point: Equatable {
    
    // MARK: - `Equatable`
    
    public static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
