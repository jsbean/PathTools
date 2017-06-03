//
//  Rectangle.swift
//  PathTools
//
//  Created by James Bean on 6/3/17.
//
//

import ArithmeticTools

/// A structure that contains the location and dimensions of a rectangle.
public struct Rectangle {
    
    // MARK: - Instance Properties
    
    public static let zero = Rectangle()
    
    public var minX: Double {
        return (size.width < 0) ? origin.x + size.width : origin.x
    }
    
    public var midX: Double {
        return origin.x + (size.width / 2.0)
    }
    
    public var maxX: Double {
        return (size.width < 0) ? origin.x : origin.x + size.width
    }
    
    public var minY: Double {
        return (size.height < 0) ? origin.y + size.height : origin.y
    }
    
    public var midY: Double {
        return origin.y + (size.height / 2.0)
    }
    
    public var maxY: Double {
        return (size.height < 0) ? origin.y : origin.y + size.height
    }
    
    /// - Returns: whether a rectangle has zero width or height, or is a null rectangle.
    public var isEmpty: Bool {
        return size.width == 0 || size.height == 0
    }
    
    /// Origin.
    public let origin: Point
    
    /// Size.
    public let size: Size
    
    // MARK: - Initializers
    
    /// Creates a `Rectangle` with the given `origin` and the given `size`.
    public init(origin: Point = Point(), size: Size = Size()) {
        self.origin = origin
        self.size = size
    }
    
    /// Creates a `Rectangle` with the given `x`, `y`, `width`, and `height` values.
    public init(x: Double, y: Double, width: Double, height: Double) {
        self.origin = Point(x: x, y: y)
        self.size = Size(width: width, height: height)
    }

    // MARK: - Instance Methods
    
    public func contains(_ point: Point) -> Bool {
        return (point.x >= minX && point.x <= maxX) && (point.y >= minY && point.y <= maxY)
    }
}

extension Rectangle: Equatable {
    
    // MARK: - Equatable
    
    public static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        return lhs.origin == rhs.origin && lhs.size == rhs.size
    }
}

extension Rectangle: Monoid {
    
    public static let unit = Rectangle()
    
    public static func + (lhs: Rectangle, rhs: Rectangle) -> Rectangle {
        let minY = least(lhs.minY, lhs.minY)
        let minX = least(lhs.minX, rhs.minX)
        let maxY = greatest(lhs.maxY, rhs.maxY)
        let maxX = greatest(lhs.maxX, rhs.maxX)
        let origin = Point(x: minX, y: minY)
        let size = Size(width: maxX - minX, height: maxY - minY)
        return Rectangle(origin: origin, size: size)
    }
}

// TODO: Move to dn-m/ArithmeticTools
func greatest <T: Comparable> (_ a: T, _ b: T) -> T {
    return a > b ? a : b
}

// TODO: Move to dn-m/ArithmeticTools
func least <T: Comparable> (_ a: T, _ b: T) -> T {
    return a < b ? a : b
}
