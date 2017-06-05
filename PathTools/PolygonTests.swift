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
}
