//
//  LineTests.swift
//  PathTools
//
//  Created by James Bean on 6/6/17.
//
//

import XCTest
import PathTools

class LineTests: XCTestCase {
    
    func testLineLengthHorizontal() {
        let line = Line(start: Point(), end: Point(x: 1, y: 0))
        XCTAssertEqual(line.length, 1)
    }
    
    func testLineLengthVertical() {
        let line = Line(start: Point(), end: Point(x: 0, y: 1))
        XCTAssertEqual(line.length, 1)
    }
    
    func testLineLengthPositiveDiagonal() {
        let line = Line(start: Point(), end: Point(x: 1, y: -1))
        XCTAssertEqual(line.length, sqrt(2))
    }
}
