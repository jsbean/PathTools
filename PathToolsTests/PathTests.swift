//
//  PathTests.swift
//  PathTools
//
//  Created by James Bean on 6/10/16.
//
//

import XCTest
@testable import PathTools

class PathTests: XCTestCase {

    func testInit() {
        let _ = Path()
    }
    
    func testMoveTo() {
        var path = Path()
        path.move(to: CGPointZero)
        XCTAssertEqual(path.count, 1)
    }
    
    func testMoveToLineTo() {
        var path = Path()
        path.move(to: CGPointZero)
        path.addLine(to: CGPointZero)
        XCTAssertEqual(path.count, 2)
    }
    
    func testCGPathInit() {
        let path = Path()
        let _ = path.cgPath
    }
    
    func testInitWithCGRect() {
        let rect = CGRect(origin: CGPointZero, size: CGSizeZero)
        let _ = Path.rectangle(rect)
    }
    
//    func testPerformanceThousandsCGPathRects() {
//        self.measureBlock {
//            (0 ..< 100_000).forEach { _ in
//                let path = CGPathCreateMutable()
//                CGPathAddRect(path, nil, CGRectZero)
//            }
//        }
//    }
//    
//    func testPerformanceThousandsOfRectangles() {
//        self.measureBlock {
//            (0 ..< 100_000).forEach { _ in
//                let _ = Path.rectangle(CGRectZero)
//            }
//        }
//    }
//    
//    func testPerformanceThousandsUIBezierPathRects() {
//        self.measureBlock {
//            (0 ..< 100_000).forEach { _ in
//                let _ = UIBezierPath(rect: CGRectZero)
//            }
//        }
//    }
}
