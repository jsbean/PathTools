//
//  Path+Polygon.swift
//  PathTools
//
//  Created by James Bean on 6/5/17.
//
//

import Collections

public class Polygon: Path {
    
    public init(vertices: [Point]) {
        
        guard vertices.count >= 3 else {
            fatalError("Cannot create a polygon without at least three vertices!")
        }
        
        let (first, rest) = vertices.destructured!
        super.init([.move(first)] + rest.map { .line($0) } + PathElement.close)
    }
}
