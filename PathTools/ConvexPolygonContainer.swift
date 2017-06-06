//
//  ConvexPolygonContainer.swift
//  PathTools
//
//  Created by James Bean on 6/6/17.
//
//

/// Contains one or more `ConvexPolygonProtocol`-conforming types, for the purposes of 
/// collision detection.
public struct ConvexPolygonContainer {
    
    public let polygons: [ConvexPolygonProtocol]
    
    public init <S: Sequence> (_ polygons: S) where S.Iterator.Element: ConvexPolygonProtocol {
        self.polygons = Array(polygons)
    }
    
    public init(_ convexPolygon: ConvexPolygonProtocol) {
        self.polygons = [convexPolygon]
    }
}
