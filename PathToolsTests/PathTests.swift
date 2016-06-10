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
        
    }
}
