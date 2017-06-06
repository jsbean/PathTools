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
        
        let rect = Path.rectangle(origin: Point(), size: Size(width: 100, height: 100))
        
        let a = Polygon(rect)!
        let b = Polygon(rect)!
        
        XCTAssert(collision(a,b))
    }
    
    func testRectsSeparatedAboveIntersectingFalse() {
        
        let a = Polygon(Path.rectangle(origin: Point(), size: Size(width: 100, height: 100)))!
        let b = Polygon(
            Path.rectangle(
                origin: Point(x: 0, y: -101),
                size: Size(width: 100, height: 100)
            )
        )!
        
        XCTAssertFalse(collision(a,b))
    }
    
    func testRectangleDiamondSeparatedIntersectingFalse() {
        
        let a = Polygon(Path.rectangle(origin: Point(), size: Size(width: 100, height: 100)))!
        let b = Polygon(
            Path()
                .move(to: Point(x: 150, y: 200))
                .addLine(to: Point(x: 225, y: 150))
                .addLine(to: Point(x: 150, y: 75))
                .addLine(to: Point(x: 75, y: 150))
                .close()
        )!
        
        XCTAssertFalse(collision(a,b))
    }
    
    func testContainsPointInRectTrue() {

        let rect = Polygon(
            Path.rectangle(origin: Point(), size: Size(width: 100, height: 100))
        )!
        
        let point = Point(x: 50, y: 50)
        
        XCTAssert(rect.contains(point))
    }
    
    func testContainsPointInRectFalse() {
        
        let rect = Polygon(
            Path.rectangle(origin: Point(), size: Size(width: 100, height: 100))
        )!
        
        let point = Point(x: -1, y: 0)
        
        XCTAssertFalse(rect.contains(point))
    }
    
    func testYsAtXRect() {
        
        let rect = Polygon(
            Path.rectangle(origin: Point(), size: Size(width: 100, height: 100))
        )!
        
        let expected: Set<Double> = [0,100]
        
        XCTAssertEqual(expected, rect.ys(at: 25))
    }
    
    func testXsAtYRect() {
        
        let rect = Polygon(
            Path.rectangle(origin: Point(), size: Size(width: 100, height: 100))
        )!
        
        let expected: Set<Double> = [0,100]
        
        XCTAssertEqual(expected, rect.xs(at: 75))
    }
}
