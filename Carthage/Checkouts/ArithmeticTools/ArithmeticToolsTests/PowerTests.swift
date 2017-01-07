//
//  PowerTests.swift
//  ArithmeticTools
//
//  Created by James Bean on 3/2/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import ArithmeticTools

class PowerTests: XCTestCase {

    func testClosestPowerOfTwoUnder() {
        let closest = closestPowerOfTwo(under: 7)!
        XCTAssertEqual(closest, 4)
    }
    
    func testClosestPowerOf2() {
        let closest = closestPowerOfTwo(to: 19)!
        XCTAssertEqual(closest, 16)
    }
    
    func testClosestPowerOf2_coeff2() {
        let closest = closestPowerOfTwo(withCoefficient: 2, to: 13)!
        XCTAssertEqual(closest, 16)
    }
    
    func testClosestPowerOf2_coeff3() {
        let closest = closestPowerOfTwo(withCoefficient: 3, to: 11)!
        XCTAssertEqual(closest, 12)
    }
    
    func testClosestPowerOf2_coeff11() {
        let closest = closestPowerOfTwo(withCoefficient: 11, to: 13)!
        XCTAssertEqual(closest, 11)
    }
    
    func testInBetween() {
        let closest = closestPowerOfTwo(to: 12)!
        XCTAssertEqual(closest, 8)
    }
}
