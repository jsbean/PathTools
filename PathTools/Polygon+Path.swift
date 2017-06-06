//
//  Polygon+Path.swift
//  PathTools
//
//  Created by James Bean on 6/6/17.
//
//

extension Polygon {
    
    public init?(_ path: Path) {
        
        let vertices = path.elements.flatMap { $0.point }
        
        guard vertices.count >= 3 else {
            return nil
        }
        
        self.init(vertices: vertices)
    }
}
