//
//  EvenTests.swift
//  ArithmeticTools
//
//  Created by James Bean on 2/18/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import ArithmeticTools

class EvenTests: XCTestCase {
    
    func testIntEvenTrue() {
        XCTAssertTrue(222.isEven)
    }
    
    func testIntEvenFalse() {
        XCTAssertFalse(333.isEven)
    }
    
    func testFloatEvenTrue() {
        XCTAssertTrue(222.0.isEven)
    }
    
    func testFloatEvenFalse() {
        XCTAssertFalse(333.isEven)
    }
    
    func testFloatEvenFalseDecimal() {
        XCTAssertFalse(2.3.isEven)
    }
}
