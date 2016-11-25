//
//  ArrayExtension.swift
//  ArithmeticTools
//
//  Created by James Bean on 2/16/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import ArrayTools

// Move this up to extension of `BidirectionalCollection`.
extension Array where Element: ArithmeticType {
    
    /// Average of elements in Array.
    public var mean: Float? {
        if count == 0 { return nil }
        switch sum {
        case let sum as Int: return Float(sum) / Float(count)
        case let sum as Int8: return Float(sum) / Float(count)
        case let sum as UInt8: return Float(sum) / Float(count)
        case let sum as Int16: return Float(sum) / Float(count)
        case let sum as UInt16: return Float(sum) / Float(count)
        case let sum as Int32: return Float(sum) / Float(count)
        case let sum as UInt32: return Float(sum) / Float(count)
        case let sum as Int64: return Float(sum) / Float(count)
        case let sum as UInt64: return Float(sum) / Float(count)
        case let sum as Float: return sum / Float(count)
        case let sum as Double: return Float(sum) / Float(count)
        default: fatalError("Unable to compute value")
        }
    }
    
    /** 
     Cumulative representation of elements in Array.
     
     >`[1,2,2].cumulative -> [0,1,3]`
    */
    public var cumulative: [Element] {
        func accumulate(_ array: [Element], result: [Element], sum: Element) -> [Element] {
            guard let (head, tail) = array.destructured else { return result }
            return accumulate(tail, result: result + [sum], sum: sum + head)
        }
        return accumulate(self, result: [], sum: Element.zero)
    }
    
    /**
     Returns (position, value).
     
     >`[1,2,2].cumulativeWithValue -> [(0,1),(1,2),(3,2)]`
    */
    public var cumulativeWithValue: [(Element, Element)] {
        func accumulate(_ array: [Element], result: [(Element, Element)], sum: Element)
            -> [(Element, Element)]
        {
            guard let (head, tail) = array.destructured else { return result }
            return accumulate(tail, result: result + [(sum + head, head)], sum: sum + head)
        }
        return accumulate(self, result: [], sum: Element.zero)
    }
    
    /**
     Get the closest value in Array to target value.
     
     - parameter target: Value to check for closest component
     
     - returns: Value closest to target is !self.isEmpty. Otherwise nil.
     
     - TODO: Consider moving this up to an extension of `Sequence`.
     */
    public func closest(to target: Element) -> Element? {
        guard !self.isEmpty else { return nil }
        var cur = self[0]
        var diff = Element.abs(target - cur)
        for el in self {
            let newDiff = Element.abs(target - el)
            if newDiff < diff {
                diff = newDiff
                cur = el
            }
        }
        return cur
    }
}
