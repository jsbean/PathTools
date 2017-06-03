//
//  Size.swift
//  PathTools
//
//  Created by James Bean on 6/3/17.
//
//

public struct Size {
    
    public let width: Double
    public let height: Double
    
    public init(width: Double = 0, height: Double = 0) {
        self.width = width
        self.height = height
    }
}

extension Size: Equatable {
    
    public static func == (lhs: Size, rhs: Size) -> Bool {
        return lhs.width == rhs.width && lhs.height == rhs.height
    }
}
