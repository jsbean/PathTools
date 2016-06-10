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
        var path = Path()
        let _ = path.cgPath
    }
    
    func testInitWithCGRect() {
        let rect = CGRect(origin: CGPointZero, size: CGSizeZero)
        let _ = Path(rect)
    }
}
