//
//  PowerGeneratorTests.swift
//  ArithmeticTools
//
//  Created by James Bean on 3/2/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import ArithmeticTools

class PowerGeneratorTests: XCTestCase {

    func testInt_1() {
        let powerGenerator = PowerGenerator(coefficient: 1, max: 10)
        var array: [Int] = []
        while let p = powerGenerator.next() { array.append(p) }
        XCTAssertEqual(array, [1,2,4,8])
    }
    
    func testInt_3() {
        let powerGenerator = PowerGenerator(coefficient: 3, max: 24)
        var array: [Int] = []
        while let p = powerGenerator.next() { array.append(p) }
        XCTAssertEqual(array, [3,6,12,24])
    }
    
    func testOvershoot() {
        let powerGenerator = PowerGenerator(coefficient: 3, max: 13, doOvershoot: true)
        var array: [Int] = []
        while let p = powerGenerator.next() { array.append(p) }
        XCTAssertEqual(array, [3,6,12,24])
    }
}
