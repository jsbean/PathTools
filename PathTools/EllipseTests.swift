//
//  EllipseTests.swift
//  PathTools
//
//  Created by James Bean on 6/4/17.
//
//

import XCTest
import PathTools

class EllipseTests: XCTestCase {
    
    func testEllipse() {
        let rect = Rectangle(x: 0, y: 0, width: 50, height: 100)
        let ellipse = Path.ellipse(in: rect)
        
    }
}