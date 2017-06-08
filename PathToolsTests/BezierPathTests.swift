//
//  BezierPathTests.swift
//  PathTools
//
//  Created by James Bean on 6/8/17.
//
//

import XCTest
import GeometryTools
import PathTools

class BezierPathTests: XCTestCase {
    
    func testLinear() {
        
        let linear = QuadraticBezierCurve(
            start: Point(),
            end: Point(x: 1, y: 1),
            controlPoint: Point(x: 0.5, y: 0.5)
        )
    
        stride(from: Double(0), to: 1, by: 0.01).forEach { t in
            XCTAssertEqualWithAccuracy(linear.x(t: t), t, accuracy: 0.000001)
        }
    }
    
    // FIXME: Add assertions!
    func testSimpleQuadraticPointAtT() {
        
        let easeIn = QuadraticBezierCurve(
            start: Point(),
            end: Point(x: 1, y: 1),
            controlPoint: Point(x: 1, y: 0)
        )
        
        stride(from: Double(0), to: 1, by: 0.1).forEach { t in
            print("ease in [\(t)] \(easeIn.point(t: t))")
        }
        
        let easeOut = QuadraticBezierCurve(
            start: Point(),
            end: Point(x: 1, y: 1),
            controlPoint: Point(x: 0, y: 1)
        )
        
        stride(from: Double(0), to: 1, by: 0.1).forEach { t in
            print("ease out [\(t)] \(easeOut.point(t: t))")
        }
    }
}
