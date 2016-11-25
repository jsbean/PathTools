//
//  QuadraticTests.swift
//  PathTools
//
//  Created by James Bean on 11/24/16.
//
//

import XCTest
import PathTools

class QuadraticTests: XCTestCase {
    
    func testIsEmpty() {
        XCTAssert(quadratic(2,1,3).isEmpty)
    }
    
    func testQuadratic() {
        XCTAssertEqual(quadratic(5,6,1), [-1, -0.2])
    }
}
