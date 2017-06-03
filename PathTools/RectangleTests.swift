//
//  RectangleTests.swift
//  PathTools
//
//  Created by James Bean on 6/3/17.
//
//

import XCTest
import PathTools

public class RectangleTests: XCTestCase {
    
    func testAdd() {

        // (-5,-5), (10,-5), (10,10), (-5,10)
        let a = Rectangle(x: -5, y: -5, width: 15, height: 15)
        
        // (3,3), (15,3), (20,20), (3,20)
        let b = Rectangle(x: 3, y: 3, width: 12, height: 17)
        
        // (-5,-5), (15,-5), (20,20), (-5,20)
        let expected = Rectangle(x: -5, y: -5, width: 20, height: 25)
        
        XCTAssertEqual(a + b, expected)
    }
}
