//
//  PowerSequenceTests.swift
//  ArithmeticTools
//
//  Created by James Bean on 3/2/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import ArithmeticTools

class PowerSequenceTests: XCTestCase {

    func testforLoop() {
        var array: [Float] = []
        for p in PowerSequence(coefficient: Float(1.0), max: Float(64.0)) { array.append(p) }
        XCTAssertEqual(array, [1.0, 2.0, 4.0, 8.0, 16.0, 32.0, 64.0])
    }
    
    func testFilter() {
        let powerSequence = PowerSequence(coefficient: 1, max: 128)
        let filtered = powerSequence.filter { $0 >= 4 && $0 <= 32 }
        XCTAssertEqual(filtered, [4,8,16,32])
    }
    
    func testNon2Base_3() {
        let powerSequence = PowerSequence(coefficient: 3, max: 24)
        let mapped = powerSequence.map { $0 }
        XCTAssertEqual(mapped, [3,6,12,24])
    }
    
    func testNon2Base_7() {
        let powerSequence = PowerSequence(coefficient: 7, max: 56).map { $0 }
        XCTAssertEqual(powerSequence, [7,14,28,56])
    }
    
    func testOvershoot() {
        let powerSequence = PowerSequence(coefficient: 2, max: 13, doOvershoot: true).map { $0 }
        XCTAssertEqual(powerSequence, [2,4,8,16])
    }
}
