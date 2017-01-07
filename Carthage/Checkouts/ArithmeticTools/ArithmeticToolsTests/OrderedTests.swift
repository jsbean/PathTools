//
//  OrderedTests.swift
//  ArithmeticTools
//
//  Created by James Bean on 3/12/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import ArithmeticTools

class OrderedTests: XCTestCase {
    
    func testOrderedEqual() {
        let a = 4
        let b = 4
        let (newA, newB) = ordered(a, b)
        XCTAssertEqual(newA, a)
        XCTAssertEqual(newB, b)
    }
    
    func testOrderInOrder() {
        let a = 4
        let b = 5
        let (newA, newB) = ordered(a, b)
        XCTAssertEqual(newA, a)
        XCTAssertEqual(newB, b)
    }
    
    func testOrderNeedsOrdering() {
        let a = 5
        let b = 4
        let (newB, newA) = ordered(a, b)
        XCTAssertEqual(newA, a)
        XCTAssertEqual(newB, b)
    }
}
