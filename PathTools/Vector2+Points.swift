//
//  Vector2+Points.swift
//  PathTools
//
//  Created by James Bean on 6/3/17.
//
//

import ArithmeticTools

extension Vector2 {
    
    /// Creates a `Vector2` with two `Point` values.
    public init(_ a: Point, _ b: Point) {
        self.init(x: b.x - a.x, y: b.y - a.y)
    }
}
