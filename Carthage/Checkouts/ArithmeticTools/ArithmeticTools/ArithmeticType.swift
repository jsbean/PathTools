//
//  ArithmeticType.swift
//  ArithmeticTools
//
//  Created by James Bean on 2/16/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/**
 ArithmeticType unifies IntegerLiteralConvertible types (Integer and FloatingPoint) for
 generic use.
 
 - TODO: Conform to `IntegerLiteralConvertible` / `FloatLiteralConvertible` ?
 - TODO: Implement `limited(by: Self) -> Self`
 */
public protocol ArithmeticType: Comparable {
    
    // MARK: - Type Properties
    
    /// Maximum value for conforming type
    static var max: Self { get }
    
    /// Minumum value for conforming type
    static var min: Self { get }
    
    static var zero: Self { get }
    static var one: Self { get }
    static var two: Self { get }
    
    // MARK: - Type Methods
    
    /**
    Make a random value for conforming type
    
    - parameter min: Lower bound (inclusive) for random value
    - parameter max: Upper bound (inclusive) for random value
    
    - returns: Random value in specified range
    */
    static func random(min: Self, max: Self, resolution: Self) -> Self

    // MARK: - Arithmetic Binary Operators
    
    /**
    Get the sum of two ArithmeticType values.
    
    - parameter augend: Augend
    - parameter addend: Addend
    
    - returns: Sum of augend and addend
    */
    static func + (augend: Self, addend: Self) -> Self
    
    /**
     Get the difference of two ArithmeticType values.
     
     - parameter minuend:    Minuend
     - parameter subtrahend: Subtrahend
     
     - returns: Difference of minuend and subtrahend
     */
    static func - (minuend: Self, subtrahend: Self) -> Self
    
    /**
     Get the product of two ArithmeticType values.
     
     - parameter multiplicand: Multiplicand
     - parameter multiplier:   Multiplier
     
     - returns: Product of multiplicand and multiplier
     */
    static func * (multiplicand: Self, multiplier: Self) -> Self
    
    /**
     Get the quotient of two ArithmeticType values.
     
     - parameter dividend: Dividend
     - parameter divisor:  Divisor
     
     - returns: Quotient of dividend and divisor
     */
    static func / (dividend: Self, divisor: Self) -> Self
    
    /**
     Get the remainder of two ArithmeticType values.
     
     - parameter dividend: Dividend
     - parameter modulus:  Modulus
     
     - returns: Remainder of dividend and modulus
     */
    static func mod (_ dividend: Self, _ modulus: Self) -> Self
    
    // MARK: - Arithmetic Unary Operators
    
    /**
    Get the absolute value of ArithmeticType value.
    
    - parameter value: Value for which to get absolute value
    
    - returns: Absolute value of value
    */
    static func abs(_ value: Self) -> Self
    
    // MARK: - Instance Properties
    
    /// If ArithmeticType value is integral.
    var isInteger: Bool { get }
    
    /// If ArithmeticType value is prime.
    var isPrime: Bool { get }
    
    /// If ArithmeticType value is even.
    var isEven: Bool { get }
    
    /// If ArithmeticType value is odd.
    var isOdd: Bool { get }
    
    /// If ArithmeticType value is a power-of-two.
    var isPowerOfTwo: Bool { get }
    
    // MARK: Instance Methods
    
    func isDivisible(by value: Self) -> Bool
    
    func format(_ f: String) -> String
}

extension Int: ArithmeticType {
    
    public static var zero: Int { return 0 }
    public static var one: Int { return 1 }
    public static var two: Int { return 2 }
    
    public static func mod(_ dividend: Int, _ modulus: Int) -> Int {
        let result = dividend % modulus
        return result < 0 ? result + modulus : result
    }
    
    /// - returns: random value
    ///
    /// - warning: `resolution` not implemented!
    public static func random(
        min: Int = Int.min,
        max: Int = Int.max,
        resolution: Int = Int.one
    ) -> Int
    {
        let max = max >= Int(UInt32.max / 2) ? Int(UInt32.max / 2) : max - 1
        let min = min <= Int(UInt32.min / 2) ? Int(UInt32.min / 2) : min + 1
        let range = max - min
        return Int(arc4random_uniform(UInt32(range))) + min
    }
    
    public static func abs(_ value: Int) -> Int {
        return value < 0 ? -value : value
    }
    
    public var isInteger: Bool { return true }
    
    public var isPrime: Bool {
        if self <= 1 { return false }
        if self <= 3 { return true }
        var i = 2
        while i * i <= self {
            if self % i == 0 { return false }
            i = i + 1
        }
        return true
    }
    
    public var isEven: Bool { return self % 2 == 0 }
    public var isOdd: Bool { return self % 2 != 0 }
    public var isPowerOfTwo: Bool { return self != 0 && (self & (self - 1) == 0) }
    
    public func isDivisible(by value: Int) -> Bool { return self % value == 0 }
    
    public func format(_ f: String) -> String {
        return String(format: f, self)
    }
}

extension Int8: ArithmeticType {
    
    public static var zero: Int8 { return 0 }
    public static var one: Int8 { return 1 }
    public static var two: Int8 { return 2 }
    
    public static func mod(_ dividend: Int8, _ modulus: Int8) -> Int8 {
        let result = dividend % modulus
        return result < 0 ? result + modulus : result
    }
    
    public static func random(
        min: Int8 = Int8.min,
        max: Int8 = Int8.max,
        resolution: Int8 = 1
    ) -> Int8
    {
        return Int8(Int.random(min: Int(min), max: Int(max), resolution: Int(resolution)))
    }
    
    public static func abs(_ value: Int8) -> Int8 {
        return value < 0 ? -value : value
    }
    
    public var isInteger: Bool { return true }
    public var isPrime: Bool { return Int(self).isPrime }
    public var isEven: Bool { return Int(self).isEven }
    public var isOdd: Bool { return Int(self).isOdd }
    public var isPowerOfTwo: Bool { return Int(self).isPowerOfTwo }

    public func isDivisible(by value: Int8) -> Bool {
        return Int(self).isDivisible(by: Int(value))
    }
    
    public func format(_ f: String) -> String {
        return String(format: f, self)
    }
}

extension UInt8: ArithmeticType {
    
    public static var zero: UInt8 { return 0 }
    public static var one: UInt8 { return 1 }
    public static var two: UInt8 { return 2 }
    
    public static func mod(_ dividend: UInt8, _ modulus: UInt8) -> UInt8 {
        let result = dividend % modulus
        return result < 0 ? result + modulus : result
    }
    
    public static func random(
        min: UInt8 = UInt8.min,
        max: UInt8 = UInt8.max,
        resolution: UInt8 = 1
    ) -> UInt8
    {
        return UInt8(Int.random(min: Int(min), max: Int(max), resolution: Int(resolution)))
    }
    
    public static func abs(_ value: UInt8) -> UInt8 {
        return value
    }
    
    public var isInteger: Bool { return true }
    public var isPrime: Bool { return Int(self).isPrime }
    public var isEven: Bool { return Int(self).isEven }
    public var isOdd: Bool { return Int(self).isOdd }
    public var isPowerOfTwo: Bool { return Int(self).isPowerOfTwo }
    
    public func isDivisible(by value: UInt8) -> Bool {
        return Int(self).isDivisible(by: Int(value))
    }
    
    public func format(_ f: String) -> String {
        return String(format: f, self)
    }
}

extension Int16: ArithmeticType {
    
    public static var zero: Int16 { return 0 }
    public static var one: Int16 { return 1 }
    public static var two: Int16 { return 2 }
    
    public static func mod(_ dividend: Int16, _ modulus: Int16) -> Int16 {
        let result = dividend % modulus
        return result < 0 ? result + modulus : result
    }
    
    public static func random(
        min: Int16 = Int16.min,
        max: Int16 = Int16.max,
        resolution: Int16 = 1
    ) -> Int16
    {
        return Int16(Int.random(min: Int(min), max: Int(max), resolution: Int(resolution)))
    }
    
    public static func abs(_ value: Int16) -> Int16 {
        return value < 0 ? -value : value
    }
    
    public var isInteger: Bool { return true }
    public var isPrime: Bool { return Int(self).isPrime }
    public var isEven: Bool { return Int(self).isEven }
    public var isOdd: Bool { return Int(self).isOdd }
    public var isPowerOfTwo: Bool { return Int(self).isPowerOfTwo }
    
    public func isDivisible(by value: Int16) -> Bool {
        return Int(self).isDivisible(by: Int(value))
    }
    
    public func format(_ f: String) -> String {
        return String(format: f, self)
    }
}

extension UInt16: ArithmeticType {
    
    public static var zero: UInt16 { return 0 }
    public static var one: UInt16 { return 1 }
    public static var two: UInt16 { return 2 }
    
    public static func mod(_ dividend: UInt16, _ modulus: UInt16) -> UInt16 {
        let result = dividend % modulus
        return result < 0 ? result + modulus : result
    }
    
    public static func random(
        min: UInt16 = UInt16.min,
        max: UInt16 = UInt16.max,
        resolution: UInt16 = 1
    ) -> UInt16
    {
        return UInt16(Int.random(min: Int(min), max: Int(max), resolution: Int(resolution)))
    }
    
    public static func abs(_ value: UInt16) -> UInt16 {
        return value
    }
    
    public var isInteger: Bool { return true }
    public var isPrime: Bool { return Int(self).isPrime }
    public var isEven: Bool { return Int(self).isEven }
    public var isOdd: Bool { return Int(self).isOdd }
    public var isPowerOfTwo: Bool { return Int(self).isPowerOfTwo }
    
    public func isDivisible(by value: UInt16) -> Bool {
        return Int(self).isDivisible(by: Int(value))
    }
    
    public func format(_ f: String) -> String {
        return String(format: f, self)
    }
}

extension Int32: ArithmeticType {
    
    public static var zero: Int32 { return 0 }
    public static var one: Int32 { return 1 }
    public static var two: Int32 { return 2 }
    
    public static func mod(_ dividend: Int32, _ modulus: Int32) -> Int32 {
        let result = dividend % modulus
        return result < 0 ? result + modulus : result
    }
    
    public static func random(
        min: Int32 = Int32.min,
        max: Int32 = Int32.max,
        resolution: Int32 = 1
    ) -> Int32
    {
        return Int32(Int.random(min: Int(min), max: Int(max), resolution: Int(resolution)))
    }
    
    public static func abs(_ value: Int32) -> Int32 {
        return value < 0 ? -value : value
    }
    
    public var isInteger: Bool { return true }
    public var isPrime: Bool { return Int(self).isPrime }
    public var isEven: Bool { return Int(self).isEven }
    public var isOdd: Bool { return Int(self).isOdd }
    public var isPowerOfTwo: Bool { return Int(self).isPowerOfTwo }
    
    public func isDivisible(by value: Int32) -> Bool {
        return Int(self).isDivisible(by: Int(value))
    }
    
    public func format(_ f: String) -> String {
        return String(format: f, self)
    }
}


extension UInt32: ArithmeticType {
    
    public static var zero: UInt32 { return 0 }
    public static var one: UInt32 { return 1 }
    public static var two: UInt32 { return 2 }
    
    public static func mod(_ dividend: UInt32, _ modulus: UInt32) -> UInt32 {
        let result = dividend % modulus
        return result < 0 ? result + modulus : result
    }
    
    public static func random(
        min: UInt32 = UInt32.min,
        max: UInt32 = UInt32.max,
        resolution: UInt32 = 1
    ) -> UInt32
    {
        return UInt32(Int.random(min: Int(min), max: Int(max), resolution: Int(resolution)))
    }

    public static func abs(_ value: UInt32) -> UInt32 {
        return value
    }
    
    public var isInteger: Bool { return true }
    public var isPrime: Bool { return Int(self).isPrime }
    public var isEven: Bool { return Int(self).isEven }
    public var isOdd: Bool { return Int(self).isOdd }
    public var isPowerOfTwo: Bool { return Int(self).isPowerOfTwo }
    
    public func isDivisible(by value: UInt32) -> Bool {
        return Int(self).isDivisible(by: Int(value))
    }
    
    public func format(_ f: String) -> String {
        return String(format: f, self)
    }
}

extension Int64: ArithmeticType {
    
    public static var zero: Int64 { return 0 }
    public static var one: Int64 { return 1 }
    public static var two: Int64 { return 2 }
    
    public static func mod(_ dividend: Int64, _ modulus: Int64) -> Int64 {
        let result = dividend % modulus
        return result < 0 ? result + modulus : result
    }
    
    public static func random(
        min: Int64 = Int64.min,
        max: Int64 = Int64.max,
        resolution: Int64 = 1
    ) -> Int64
    {
        return Int64(Int.random(min: Int(min), max: Int(max), resolution: Int(resolution)))
    }
    
    public static func abs(_ value: Int64) -> Int64 {
        return value < 0 ? -value : value
    }
    
    public var isInteger: Bool { return true }
    public var isPrime: Bool { return Int(self).isPrime }
    public var isEven: Bool { return Int(self).isEven }
    public var isOdd: Bool { return Int(self).isOdd }
    public var isPowerOfTwo: Bool { return Int(self).isPowerOfTwo }
    
    public func isDivisible(by value: Int64) -> Bool {
        return Int(self).isDivisible(by: Int(value))
    }
    
    public func format(_ f: String) -> String {
        return String(format: f, self)
    }
}

extension UInt64: ArithmeticType {
    
    public static var zero: UInt64 { return 0 }
    public static var one: UInt64 { return 1 }
    public static var two: UInt64 { return 2 }
    
    public static func mod(_ dividend: UInt64, _ modulus: UInt64) -> UInt64 {
        let result = dividend % modulus
        return result < 0 ? result + modulus : result
    }
    
    public static func random(
        min: UInt64 = UInt64.min,
        max: UInt64 = UInt64.max,
        resolution: UInt64 = 1
    ) -> UInt64
    {
        return UInt64(Int.random(min: Int(min), max: Int(max), resolution: Int(resolution)))
    }
    
    public static func abs(_ value: UInt64) -> UInt64 {
        return value
    }
    
    public var isInteger: Bool { return true }
    public var isPrime: Bool { return Int(self).isPrime }
    public var isEven: Bool { return Int(self).isEven }
    public var isOdd: Bool { return Int(self).isOdd }
    public var isPowerOfTwo: Bool { return Int(self).isPowerOfTwo }
    
    public func isDivisible(by value: UInt64) -> Bool {
        return Int(self).isDivisible(by: Int(value))
    }
    
    public func format(_ f: String) -> String {
        return String(format: f, self)
    }
}

extension Float: ArithmeticType {
    
    public static var zero: Float { return 0 }
    public static var one: Float { return 1 }
    public static var two: Float { return 2 }
    
    public static var max: Float { return FLT_MAX }
    public static var min: Float { return FLT_MIN }
    
    public static func mod(_ dividend: Float, _ modulus: Float) -> Float {
        let result = dividend.truncatingRemainder(dividingBy: modulus)
        return result < 0 ? result + modulus : result
    }
    
    public static func abs(_ value: Float) -> Float {
        return value < 0 ? -value : value
    }
    
    public static func random(min: Float = 0.0, max: Float = 1.0) -> Float {
        let range = max - min
        return ((Float(arc4random())) / Float(UINT32_MAX) * range) + min
    }
    
    public static func random(min: Float = 0.0, max: Float = 1.0, resolution: Float = 1.0) -> Float {
        return (random(min: min, max: max) * resolution).rounded() / resolution
    }
    
    public var isInteger: Bool { return self.truncatingRemainder(dividingBy: 1) == 0 }
    public var isPrime: Bool { return isInteger ? Int(self).isPrime : false }
    public var isEven: Bool { return isInteger ? Int(self).isEven : false }
    public var isOdd: Bool { return isInteger ? Int(self).isOdd : false }
    public var isPowerOfTwo: Bool { return isInteger ? Int(self).isPowerOfTwo : false }
    
    public func isDivisible(by value: Float) -> Bool {
        guard isInteger else { return false }
        return Int(self).isDivisible(by: Int(value))
    }
    
    public func format(_ f: String) -> String {
        return String(format: f, self)
    }
}

extension Double: ArithmeticType {
    
    public static var zero: Double { return 0 }
    public static var one: Double { return 1 }
    public static var two: Double { return 2 }
    
    public static var max: Double { return DBL_MAX }
    public static var min: Double { return DBL_MIN }
    
    public static func mod(_ dividend: Double, _ modulus: Double) -> Double {
        let result = dividend.truncatingRemainder(dividingBy: modulus)
        return result < 0 ? result + modulus : result
    }
    
    public static func random(
        min: Double = Double.min,
        max: Double = Double.max,
        resolution: Double = 1.0
    ) -> Double
    {
        return (random(min: min, max: max) * resolution).rounded() / resolution
    }
    
    public static func abs(_ value: Double) -> Double {
        return value < 0 ? -value : value
    }

    public var isInteger: Bool { return self.truncatingRemainder(dividingBy: 1) == 0 }
    public var isPrime: Bool { return isInteger ? Int(self).isPrime : false }
    public var isEven: Bool { return isInteger ? Int(self).isEven : false }
    public var isOdd: Bool { return isInteger ? Int(self).isOdd : false }
    public var isPowerOfTwo: Bool { return isInteger ? Int(self).isPowerOfTwo : false }
    
    public func isDivisible(by value: Double) -> Bool {
        guard isInteger else { return false }
        return Int(self).isDivisible(by: Int(value))
    }
    
    public func format(_ f: String) -> String {
        return String(format: f, self)
    }
}
