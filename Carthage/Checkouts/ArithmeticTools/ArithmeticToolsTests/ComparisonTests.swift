//
//  ComparisonTests.swift
//  ArithmeticTools
//
//  Created by James Bean on 5/11/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import ArithmeticTools

class ComparisonTests: XCTestCase {
    
    func testCompareIntsEqual() {
        XCTAssertEqual(compare(5,5), Comparison.equal)
    }
    
    func testCompareIntsLessThan() {
        XCTAssertEqual(compare(3,6), Comparison.lessThan)
    }
    
    func testCompareIntsGreaterThan() {
        XCTAssertEqual(compare(6,3), Comparison.greaterThan)
    }
}
