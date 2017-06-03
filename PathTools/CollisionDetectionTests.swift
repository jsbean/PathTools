//
//  CollisionDetectionTests.swift
//  PathTools
//
//  Created by James Bean on 6/3/17.
//
//

import PathTools
import XCTest

class CollisionDetectionTests: XCTestCase {
    
    func testEqualRectsIntersectingTrue() {
        
        let a = Path.rectangle(origin: Point(), size: Size(width: 100, height: 100))
        let b = a
        
        XCTAssert(a.intersects(b))
        XCTAssert(b.intersects(a))
    }
    
    func testRectsSeparatedAboveIntersectingFalse() {
        
        let a = Path.rectangle(origin: Point(), size: Size(width: 100, height: 100))
        let b = Path.rectangle(
            origin: Point(x: 0, y: -101),
            size: Size(width: 100, height: 100)
        )
        
        XCTAssertFalse(a.intersects(b))
        XCTAssertFalse(b.intersects(a))
    }
    
    func testRectangleDiamondSeparatedIntersectingFalse() {
        
        let a = Path.rectangle(origin: Point(), size: Size(width: 100, height: 100))
        let b = Path()
            .move(to: Point(x: 150, y: 200))
            .addLine(to: Point(x: 225, y: 150))
            .addLine(to: Point(x: 150, y: 75))
            .addLine(to: Point(x: 75, y: 150))
            .close()
        
        XCTAssertFalse(a.intersects(b))
        XCTAssertFalse(b.intersects(a))
    }
    
    func testContainsPointInRectTrue() {
        
        let rect = Path.rectangle(origin: Point(), size: Size(width: 100, height: 100))
        let point = Point(x: 50, y: 50)
        
        XCTAssert(rect.contains(point))
    }
    
    func testContainsPointInRectFalse() {
        
        let rect = Path.rectangle(origin: Point(), size: Size(width: 100, height: 100))
        let point = Point(x: -1, y: 0)
        
        XCTAssertFalse(rect.contains(point))
    }
}
