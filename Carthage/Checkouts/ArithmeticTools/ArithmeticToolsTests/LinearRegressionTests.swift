//
//  LinearRegressionTests.swift
//  ArithmeticTools
//
//  Created by James Bean on 11/8/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
import ArithmeticTools

class LinearRegressionTests: XCTestCase {

    func testMultiplyLHSEmpty() {
        
        let a: [Float] = []
        let b: [Float] = [0.5,1,2,4,8]
        
        let expected: [Float] = []
        
        XCTAssertEqual(a * b, expected)
    }
    
    func testMultiplyRHSEmpty() {
        
        let a: [Float] = [1,2,3,4,5]
        let b: [Float] = []
        
        let expected: [Float] = []
        
        XCTAssertEqual(a * b, expected)
    }
    
    func testMultiplyOperatorNotEmpty() {
        
        let a: [Float] = [1,2,3,4,5]
        let b: [Float] = [0.5,1,2,4,8]
        
        let expected: [Float] = [0.5, 2, 6, 16, 40]
        
        XCTAssertEqual(a * b, expected)
    }
    
    func testSlope1() {
        
        let xs: [Float] = [0,1,2,3]
        let ys: [Float] = [0,1,2,3]
        
        let expected: Float = 1
        
        XCTAssertEqual(slope(xs, ys), expected)
    }
    
    func testSlopeMinus1() {
        
        let xs: [Float] = [0,1,2,3]
        let ys: [Float] = [3,2,1,0]
        
        let expected: Float = -1
        
        XCTAssertEqual(slope(xs, ys), expected)
    }
    
    func testSlopeHalf() {
        
        let xs: [Float] = [0,1,2,3]
        let ys: [Float] = [0, 0.5, 1, 1.5]
        
        let expected: Float = 0.5
        
        XCTAssertEqual(slope(xs, ys), expected)
    }
    
    func testSlopeMinusHalf() {
        
        let xs: [Float] = [0,1,2,3]
        let ys: [Float] = [1.5, 1, 0.5, 0]
        
        let expected: Float = -0.5
        
        XCTAssertEqual(slope(xs, ys), expected)
    }
    
    func testLinearRegressionAfterEasy() {
        
        let values: [Float: Float] = [0:0,1:1,2:2,3:3]
        
        let expected: Float = 4
        
        XCTAssertEqual(linearRegression(values)(4), expected)
    }
    
    func testLinearRegressionInsideEasy() {
        
        let values: [Float: Float] = [0:0,1:1,2:2,3:3]
        
        let expected: Float = 2.5
        
        XCTAssertEqual(linearRegression(values)(2.5), expected)
    }
    
    func testLinearRegressionInsideHarder() {
        
        
    }
    
    func testDictionarySlopeInts() {
        
        let dict: [Int: Int] = [0:0,2:1,4:2]
        
        let expected: Float = 0.5
        
        XCTAssertEqual(slope(dict), expected)
    }
}
