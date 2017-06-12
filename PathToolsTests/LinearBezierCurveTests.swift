//
//  LinearBezierCurveTests.swift
//  PathTools
//
//  Created by James Bean on 6/12/17.
//
//

import XCTest
import GeometryTools
import PathTools

class LinearBezierCurveTests: XCTestCase {
    
    func testInit() {
        _ = LinearBezierCurve(start: Point(), end: Point(x: 1, y: 1))
    }
    
    func testPointAtT() {
        
        let linear = LinearBezierCurve(start: Point(), end: Point(x: 1, y: 1))
        let points = stride(from: 0, through: 1, by: 0.25).map { t in linear[t] }
        
        let expected = [
            Point(x: 0, y: 0),
            Point(x: 0.25, y: 0.25),
            Point(x: 0.5, y: 0.5),
            Point(x: 0.75, y: 0.75),
            Point(x: 1, y: 1)
        ]
        
        XCTAssertEqual(points, expected)
    }
}
