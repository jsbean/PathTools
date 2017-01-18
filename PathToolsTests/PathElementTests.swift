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
            CGPoint(x: 100, y: 100),
            CGPoint(x: 150, y: 150),
            CGPoint(x: 400, y: 0)
        )
        print(element)
    }
}
