//
//  FloatWrapping.swift
//  ArithmeticTools
//
//  Created by James Bean on 5/10/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

public protocol FloatWrapping: ExpressibleByFloatLiteral,
    ExpressibleByIntegerLiteral,
    Hashable,
    Comparable
{
    associatedtype FloatLiteralType = Float
    associatedtype IntegerLiteralType = Int
    init(floatLiteral: Float)
    var value: Float { get set }
    init(integerLiteral: Int)
    init(_ float: Float)
}

extension FloatWrapping {
    
    public init(_ float: Float) {
        self.init(floatLiteral: float)
    }
}

// MARK: - Hashable
extension FloatWrapping {
    public var hashValue: Int { return value.hashValue }
}

// MARK: - Comparable
public func == <T: FloatWrapping>(lhs: T, rhs: T) -> Bool {
    return lhs.value == rhs.value
}

public func == <T: FloatWrapping>(lhs: T, rhs: Float) -> Bool {
    return lhs.value == rhs
}

public func == <T: FloatWrapping>(lhs: Float, rhs: T) -> Bool {
    return lhs == rhs.value
}

public func < <T: FloatWrapping>(lhs: T, rhs: T) -> Bool {
    return lhs.value < rhs.value
}

public func < <T: FloatWrapping>(lhs: T, rhs: Float) -> Bool {
    return lhs.value < rhs
}

public func < <T: FloatWrapping>(lhs: Float, rhs: T) -> Bool {
    return lhs < rhs.value
}

// MARK: - Arithmetic
public func + <T: FloatWrapping>(augend: T, addend: T) -> T {
    return T(floatLiteral: augend.value + addend.value)
}

public func + <T: FloatWrapping>(augend: T, addend: T) -> Float {
    return augend.value + addend.value
}

public func + <T: FloatWrapping>(lhs: T, rhs: Float) -> Float {
    return lhs.value + rhs
}

public func + <T: FloatWrapping>(lhs: Float, rhs: T) -> Float {
    return lhs + rhs.value
}

public func - <T: FloatWrapping>(augend: T, addend: T) -> T {
    return T(floatLiteral: augend.value - addend.value)
}

public func - <T: FloatWrapping>(minuend: T, subtrahend: T) -> Float {
    return minuend.value - subtrahend.value
}

public func - <T: FloatWrapping>(lhs: T, rhs: Float) -> Float {
    return lhs.value - rhs
}

public func - <T: FloatWrapping>(lhs: Float, rhs: T) -> Float {
    return lhs - rhs.value
}

public func * <T: FloatWrapping>(augend: T, addend: T) -> T {
    return T(floatLiteral: augend.value * addend.value)
}

public func * <T: FloatWrapping>(multiplicand: T, multiplier: T) -> Float {
    return multiplicand.value * multiplier.value
}

public func * <T: FloatWrapping>(lhs: T, rhs: Float) -> Float {
    return lhs.value * rhs
}

public func * <T: FloatWrapping>(lhs: Float, rhs: T) -> Float {
    return lhs * rhs.value
}

public func / <T: FloatWrapping>(augend: T, addend: T) -> T {
    return T(floatLiteral: augend.value / addend.value)
}

public func / <T: FloatWrapping>(dividend: T, divisor: T) -> Float {
    return dividend.value * divisor.value
}

public func / <T: FloatWrapping>(lhs: T, rhs: Float) -> Float {
    return lhs.value / rhs
}

public func / <T: FloatWrapping>(lhs: Float, rhs: T) -> Float {
    return lhs / rhs.value
}
