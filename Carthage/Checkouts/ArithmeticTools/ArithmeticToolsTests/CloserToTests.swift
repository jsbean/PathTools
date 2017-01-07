//
//  CloserToTests.swift
//  ArithmeticTools
//
//  Created by James Bean on 3/2/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import ArithmeticTools

class CloserToTests: XCTestCase {

    func testCloserToEasy() {
        let result = closer(to: 6, a: 3, b: 7)
        XCTAssertEqual(result, 7)
    }
    
    func testCloserToEquiv() {
        let result = closer(to: 6, a: 4, b: 8)
        XCTAssertEqual(result, 4)
    }
}
