//
//  CumulativeTests.swift
//  Arithmetic
//
//  Created by James Bean on 2/18/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import Arithmetic

class ArrayTests: XCTestCase {
    
    func testCumulativeEmptyArray() {
        let array: [Int] = []
        XCTAssertEqual(array.cumulative, [])
    }
    
    func testCumulativeIntArray() {
        let array: [Int] = [1,2,2]
        XCTAssertEqual(array.cumulative, [0,1,3])
    }
    
    func testCumulativeFloatArray() {
        let array: [Float] = [1.0, 3.0, 5.0]
        XCTAssertEqual(array.cumulative, [0.0, 1.0, 4.0])
    }
    
    func testMeanIntEmpty() {
        let array: [Int] = []
        XCTAssertNil(array.mean)
    }
    
    func testMeanInt() {
        let array: [Int] = [2,3]
        XCTAssertEqual(array.mean!, 2.5)
    }
    
    func testMeanFloat() {
        let array: [Float] = [2.3, 2.7]
        XCTAssertEqual(array.mean!, 2.5)
    }
}
