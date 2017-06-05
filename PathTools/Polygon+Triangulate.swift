//
//  Polygon+Triangulate.swift
//  PathTools
//
//  Created by James Bean on 6/5/17.
//
//

import Collections
import ArithmeticTools

extension Array {
    
    /// - TODO: Move to `ArithmeticTools`
    subscript (circular index: Int) -> Element {
        return self[mod(index,count)]
    }
    
    /// - TODO: Move to `Collections`.
    func removing(at index: Int) -> [Element] {
        var copy = self
        copy.remove(at: index)
        return copy
    }
    
    /// - TODO: Move to `Collections` within `RingBuffer` or sim.
    ///
    /// - Warning: This feels terrible
    subscript (circularAfter first: Int, upTo second: Int) -> [Element] {
        
        guard first != second else {
            fatalError("Can't do this shit")
        }
        
        if second > first {
            return Array(self[first + 1 ..< second])
        } else {
            
            let back = first + 1 < endIndex ? Array(self[first + 1 ..< endIndex]) : []
            let front = Array(self[0 ..< second])
            return back + front
        }
    }
}

public enum Order {
    case clockwise
    case counterClockwise
}

extension Polygon {
    
    public var clockwise: Polygon {
        
        guard case .counterClockwise = order else {
            return self
        }
        
        return Polygon(vertices: self.vertices.reversed())
    }
    
    public var counterClockwise: Polygon {
        
        guard case .clockwise = order else {
            return self
        }
        
        return Polygon(vertices: self.vertices.reversed())
    }
    
    public var order: Order {
        let sum = edges.reduce(Double(0)) { accum, cur in
            let (a,b) = cur
            return accum + (b.x - a.x) * (b.y + a.y)
        }
        return sum > 0 ? .clockwise : .counterClockwise
    }
    
    /// Triangulate counter-clockwise `Polygon`.
    public var triangulated: [Polygon] {
        
        // Uses Ear Clipping method to split `Polygon` into array of `Triangle` values.
        
        /// - Returns: A triangle, if valid for snipping. Otherwise, `nil`.
        ///
        /// A triangle valid for snipping satisfies two requirements:
        /// - It is convex, given the order of traversal.
        /// - There are no remaining vertices contained within its area.
        ///
        func ear(at index: Int, of vertices: [Point]) -> Triangle? {
            
            let prev = vertices[circular: index - 1]
            let cur = vertices[index]
            let next = vertices[circular: index + 1]

            let triangle = Triangle(vertices: (prev,cur,next))

            // An ear must be convex, given the order of traversal.
            guard triangle.isConvex(order: .counterClockwise) else {
                return nil
            }
            
            // If we are convex, we can't have any remaining points contained inside us!
            // TODO: Refactor with a `RingBuffer` type
            let remaining = vertices[
                circularAfter: mod(index + 1, vertices.count),
                upTo: mod(index - 1, vertices.count)
            ]
            
            guard !triangle.contains(anyOf: remaining) else {
                return nil
            }
            
            return triangle
        }
        
        /// Attempts to clip off an ear at the given `index`, from the given `vertices`.
        /// If we are able to do so, we snip off the tip, and drop the ear into `ears`.
        /// Otherwise, we move on to the next vertex.
        ///
        /// - Returns: Array of `Triangle` values that cover the same area as `Polygon`.
        func clipEar(at index: Int, from vertices: [Point], into ears: [Triangle])
            -> [Triangle]
        {

            // Base case: If there are only three vertices left, we have the last triangle!
            guard vertices.count > 3 else {
                
                let prev = vertices[2]
                let cur = vertices[0]
                let next = vertices[1]
                
                return ears + Triangle(vertices: (prev,cur,next))
            }
            
            // If no ear found at current index, continue on to the next vertex.
            guard let ear = ear(at: index, of: vertices) else {
                return clipEar(at: index + 1, from: vertices, into: ears)
            }

            // Snip off tip, and proceed.
            return clipEar(at: index, from: vertices.removing(at: index), into: ears + ear)
        }
        
        return clipEar(at: 0, from: counterClockwise.vertices, into: [])
    }
}
