//
//  Path+Transform.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import QuartzCore
import GeometryTools

extension Path {
    
    // MARK: - Transforms

    /// - Returns: `Path` scaled by the given `amount` from the given `reference` point.
    public func scaled(by amount: Double, from reference: Point = Point()) -> Path {
        return Path(curves.map { $0.scaled(by: amount, from: reference) })
    }
    
    /// - Returns: `Path` rotated by the given `angle` around the given `reference` point.
    public func rotated(by angle: Angle, around reference: Point = Point()) -> Path {
        return Path(curves.map { $0.rotated(by: angle, around: reference) })
    }
    
    /// - returns: `Path` translated by the given amounts.
    public func translatedBy(x: Double = 0, y: Double = 0) -> Path {
        return Path(curves.map { $0.translatedBy(x: x, y: y) })
    }
}
