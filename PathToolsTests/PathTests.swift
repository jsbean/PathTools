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
        let path = Path()
            .move(to: Point())
        XCTAssertEqual(path.count, 1)
    }
    
    func testMoveToLineTo() {
        let path = Path()
            .move(to: Point())
            .addLine(to: Point())
        XCTAssertEqual(path.count, 2)
    }
    
    func testCGPathInit() {
        let path = Path()
        let _ = path.cgPath
    }
    
    func testInitWithCGRect() {
        let rect = Rectangle(origin: Point(), size: Size())
        let _ = Path.rectangle(rect)
    }
    
    func testCustomStringConvertible() {
        
        let path = Path()
            .move(to: Point(x: 100, y: 100))
            .addLine(to: Point(x: 200, y: 200))
            .addQuadCurve(to: Point(x: 300, y: 0), controlPoint: Point(x: 200, y: 100))
            .addCurve(
                to: Point(x: 200, y: 150),
                controlPoint1: Point(x: 400, y: 200),
                controlPoint2: Point(x: 100, y: 200)
            )
        
        print(path)
    }
    
//    func testFluentInterface() {
//        let _ = Path()
//            .move(to: CGPoint.zero)
//            .addLine(to: CGPoint.zero)
//            .addQuadCurve(to: CGPoint.zero, controlPoint: CGPoint.zero)
//            .addCurve(
//                to: CGPoint.zero,
//                controlPoint1: CGPoint.zero,
//                controlPoint2: CGPoint.zero
//            )
//    }
//    
//    func testPerformanceFluentInterface() {
//        self.measure {
//            (0 ..< 1000).forEach { _ in
//                let _ = Path()
//                    .move(to: CGPoint.zero)
//                    .addLine(to: CGPoint.zero)
//                    .addQuadCurve(to: CGPoint.zero, controlPoint: CGPoint.zero)
//                    .addCurve(
//                        to: CGPoint.zero,
//                        controlPoint1: CGPoint.zero,
//                        controlPoint2: CGPoint.zero
//                )
//            }
//        }
//    }
//    
//    func testPerformanceThousandsOfPathsFromCGPath() {
//        self.measure {
//            (0 ..< 1000).forEach { _ in
//                let cgPath = CGMutablePath()
//                cgPath.addRect(CGRect(x: 0, y: 0, width: 100, height: 100))
//                let _ = Path(cgPath)
//            }
//        }
//    }
//    
//    func testPerformanceScaled() {
//        self.measure {
//            (0 ..< 1000).forEach { _ in
//                let path = Path.rectangle(rectangle: CGRect(x: 0, y: 0, width: 100, height: 100))
//                let _ = path.scaled(by: 0.5)
//            }
//        }
//    }
//    
//    func testPerformanceRotated() {
//        self.measureBlock {
//            (0 ..< 100_000).forEach { _ in
//                let path = Path.rectangle(CGRect(x: 0, y: 0, width: 100, height: 100))
//                let rotated = path.rotated(by: 180)
//            }
//        }
//    }
    
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
