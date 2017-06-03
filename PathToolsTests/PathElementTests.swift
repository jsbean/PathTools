//
//  PathElementTests.swift
//  PathTools
//
//  Created by James Bean on 1/18/17.
//
//

import XCTest
import PathTools

class PathElementTests: XCTestCase {

    func testCustomStringConvertible() {
        let element = PathElement.curve(
            Point(x: 100, y: 100),
            Point(x: 150, y: 150),
            Point(x: 400, y: 0)
        )
        print(element)
    }
}
