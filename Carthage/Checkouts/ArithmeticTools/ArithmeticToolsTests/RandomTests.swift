//
//  RandomTests.swift
//  ArithmeticTools
//
//  Created by James Bean on 2/27/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import ArithmeticTools

class RandomTests: XCTestCase {
    
    func testDefaultInt() {
        for _ in 0..<1000 {
            let r = Int.random()
            XCTAssert(r >= 0)
            XCTAssert(r <= Int(UInt32.max / 2))
        }
    }
    
    func testIntRange() {
        for _ in 0..<1000 {
            let min = Int.random(max: 10000)
            let range = Int.random(min: 1, max: 10000)
            let r = Int.random(min: min, max: (min + range))
            XCTAssert(r >= min)
            XCTAssert(r <= (min + range))
        }
    }
    
    func testDefaultFloat() {
        for _ in 0..<1000 {
            let r = Float.random()
            XCTAssert(r >= 0.0)
            XCTAssert(r <= 1.0)
        }
    }
    
    func testFloatRange() {
        for _ in 0..<100 {
            let min = Float.random(min: 0, max: 10000)
            let range = Float.random(min: 1, max: 10000)
            let r = Float.random(min: min, max: (min + range))
            XCTAssert(r >= min)
            XCTAssert(r <= (min + range))
        }
    }
    
    func testFloatResolution4() {
        for _ in 0..<100 {
            let min = Float.random(min: 0, max: 10000)
            let range = Float.random(min: 1, max: 10000)
            let resolution: Float = 4
            let r = Float.random(min: min, max: (min + range), resolution: resolution)
            XCTAssertEqual(r.truncatingRemainder(dividingBy: (1 / resolution)), 0)
        }
    }
}
