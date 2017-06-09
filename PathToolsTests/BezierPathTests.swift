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
            control: Point(x: 0.5, y: 0.5)
        )
    
        stride(from: Double(0), to: 1, by: 0.01).forEach { t in
            XCTAssertEqualWithAccuracy(linear.x(t: t), t, accuracy: 0.000001)
        }
    }
    
    // MARK: - Quadratic
    
    public func testTAtMinX() {
        
        let slopeDown = QuadraticBezierCurve(
            start: Point(x: 0, y: 1),
            end: Point(x: 1, y: 0),
            control: Point(x: 0, y: 0)
        )
        
        XCTAssertEqual(slopeDown.t(at: (.min, .horizontal)), 0)
    }
    
    public func testTAtMaxX() {
        
        let slopeDown = QuadraticBezierCurve(
            start: Point(x: 0, y: 1),
            end: Point(x: 1, y: 0),
            control: Point(x: 0, y: 0)
        )
        
        XCTAssertEqual(slopeDown.t(at: (.max, .horizontal)), 1)
    }
    
    public func testTAtMinY() {
        
        let slopeDown = QuadraticBezierCurve(
            start: Point(x: 0, y: 1),
            end: Point(x: 1, y: 0),
            control: Point(x: 0, y: 0)
        )
        
        XCTAssertEqual(slopeDown.t(at: (.min, .vertical)), 1)
    }
    
    public func testTAtMaxY() {
        
        let slopeDown = QuadraticBezierCurve(
            start: Point(x: 0, y: 1),
            end: Point(x: 1, y: 0),
            control: Point(x: 0, y: 0)
        )
        
        XCTAssertEqual(slopeDown.t(at: (.max, .vertical)), 0)
    }
    
    public func testYsAtX() {

        let slopeDown = QuadraticBezierCurve(
            start: Point(x: 0, y: 1),
            end: Point(x: 1, y: 0),
            control: Point(x: 0, y: 0)
        )
        
        stride(from: Double(0), to: 1, by: 0.1).forEach { t in
            
            let point = slopeDown[t]
            let ys = slopeDown.ys(x: point.x)
            
            XCTAssertEqual(ys.count, 1)
            XCTAssertEqualWithAccuracy(ys.first!, point.y, accuracy: 0.0000001)
        }
    }
    
    public func testXsAtY() {
        
        let slopeDown = QuadraticBezierCurve(
            start: Point(x: 0, y: 1),
            end: Point(x: 1, y: 0),
            control: Point(x: 0, y: 0)
        )
        
        stride(from: Double(0), to: 1, by: 0.1).forEach { t in
            
            let point = slopeDown[t]
            let xs = slopeDown.xs(y: point.y)
            
            XCTAssertEqual(xs.count, 1)
            XCTAssertEqualWithAccuracy(xs.first!, point.x, accuracy: 0.0000001)
        }
    }
}
