//
//  Rectangle.swift
//  PathTools
//
//  Created by James Bean on 6/3/17.
//
//

import Collections
import ArithmeticTools

/// A structure that contains the location and dimensions of a rectangle.
public struct Rectangle: ConvexPolygonProtocol {
    
    // MARK: - Type Properties
    
    /// `Rectangle` with `origin` and `size` values of zero.
    public static let zero = Rectangle()
    
    // MARK: - Instance Properties
    
    /// Vertices comprising `Rectangle`.
    public var vertices: VertexCollection {
        let topLeft = Point(x: minX, y: maxY)
        let bottomLeft = Point(x: minX, y: minY)
        let bottomRight = Point(x: maxX, y: minY)
        let topRight = Point(x: maxX, y: maxY)
        return CircularArray([topLeft, bottomLeft, bottomRight, topRight])
    }

    /// Minimum X value.
    public var minX: Double {
        return (size.width < 0) ? origin.x + size.width : origin.x
    }
    
    /// Horizontal midpoint.
    public var midX: Double {
        return origin.x + (size.width / 2.0)
    }
    
    /// Maximum X value.
    public var maxX: Double {
        return (size.width < 0) ? origin.x : origin.x + size.width
    }
    
    /// Minimum Y value.
    public var minY: Double {
        return (size.height < 0) ? origin.y + size.height : origin.y
    }
    
    /// Vertical midpoint.
    public var midY: Double {
        return origin.y + (size.height / 2.0)
    }
    
    /// Maximum Y value.
    public var maxY: Double {
        return (size.height < 0) ? origin.y : origin.y + size.height
    }
    
    /// - Returns: `true` if the `height` or `width` properties of `size` are `0`. Otherwise,
    /// false.
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
    
    /// Creates a `Rectangle` with the given `vertices`.
    ///
    /// - Warning: Will crash if given invalid vertices.
    ///
    public init <S: Sequence> (vertices: S) where S.Iterator.Element == Point {
        try! self.init(Polygon(vertices: CircularArray(vertices)))
    }
    
    /// Creates a `Rectangle` with the given `polygon`.
    ///
    /// - Throws: `PolygonError` if the given `polygon` is not rectangular.
    ///
    public init(_ polygon: Polygon) throws {
        
        guard polygon.vertices.count == 4 else {
            
            throw PolygonError.invalidVertices(
                polygon.vertices,
                Rectangle.self,
                "A Rectangle must have four vertices!"
            )
        }
        
        guard polygon.angles.allSatisfy({ $0 == Angle(degrees: 90) }) else {
            
            throw PolygonError.invalidVertices(
                polygon.vertices,
                Rectangle.self,
                "A Rectangle must have only right angles!"
            )
        }
        
        // FIXME: Use less expensive method!
        let minX = polygon.vertices.map { $0.x }.min()!
        let maxX = polygon.vertices.map { $0.x }.max()!
        let minY = polygon.vertices.map { $0.y }.min()!
        let maxY = polygon.vertices.map { $0.y }.max()!
        
        self.init(x: minX, y: minY, width: maxX - maxX, height: maxY - minY)
    }

    // MARK: - Instance Methods
    
    /// - Returns: `true` if the given `point` is contained herein. Otherwise, `false`.
    public func contains(_ point: Point) -> Bool {
        return (point.x >= minX && point.x <= maxX) && (point.y >= minY && point.y <= maxY)
    }
}

extension Rectangle: Equatable {
    
    // MARK: - Equatable
    
    /// - Returns: `true` if values are equivalent. Otherwise, `false`.
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
