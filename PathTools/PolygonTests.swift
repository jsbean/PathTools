//
//  PolygonTests.swift
//  PathTools
//
//  Created by James Bean on 6/5/17.
//
//

import XCTest
import PathTools

class PolygonTests: XCTestCase {
    
    func testPolygon() {
        let points = [Point(x: 25, y: 25), Point(x: 100, y: 0), Point(x: -25, y: -75)]
        let polygon = Polygon(vertices: points)
        let expected = Path()
            .move(to: points[0])
            .addLine(to: points[1])
            .addLine(to: points[2])
            .close()
        XCTAssertEqual(polygon, expected)
    }
    
    func testConvexityFalse() {
        
        let polygon = Polygon(
            vertices: [
                Point(x: 10, y: 0),
                Point(x: 11, y: 20),
                Point(x: -3, y: 10),
                Point(x: -15, y: 20),
                Point(x: -15, y: 8)
            ]
        )
        
        XCTAssertFalse(polygon.isConvex)
    }
    
    func testSquareConvexityTrue() {
        let polygon = Polygon(Path.rectangle(x: 0, y: 0, width: 100, height: 100))!
        XCTAssert(polygon.isConvex)
    }
    
    func testPentagonConvexityTrue() {
        
        let polygon = Polygon(
            vertices: [
                Point(x: 5, y: -5),
                Point(x: 10, y: 5),
                Point(x: 0, y: 10),
                Point(x: -10, y: 5),
                Point(x: -5, y: -5)
            ]
        )
        
        XCTAssert(polygon.isConvex)
    }
}
