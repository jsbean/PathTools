//
//  GreatestCommonDivisorTests.swift
//  ArithmeticTools
//
//  Created by James Bean on 2/18/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import ArithmeticTools

class GreatestCommonDivisorTests: XCTestCase {
    
    func testIntALessThanB() {
        let a: Int = 8
        let b: Int = 12
        let gcd = greatestCommonDivisor(a,b)
        XCTAssertEqual(gcd, 4)
    }
    
    func testIntAGreaterThanB() {
        let a: Int = 12
        let b: Int = 8
        let gcd = greatestCommonDivisor(a,b)
        XCTAssertEqual(gcd, 4)
    }
    
    func testFloat() {
        let gcd = greatestCommonDivisor(12.0, 16.0)
        XCTAssertEqual(gcd, 4.0)
    }
}
