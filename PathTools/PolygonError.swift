//
//  PolygonError.swift
//  PathTools
//
//  Created by James Bean on 6/7/17.
//
//

/// Things that can go wrong when creating a `PolygonProtocol`-conforming type.
public enum PolygonError: Error {
    
    /// Invalid vertices, attempted shape type, message
    case invalidVertices([Point], PolygonProtocol.Type, String)
}
