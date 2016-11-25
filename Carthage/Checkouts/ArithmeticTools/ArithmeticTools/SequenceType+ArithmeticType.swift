//
//  SequenceType.swift
//  ArithmeticTools
//
//  Created by James Bean on 2/16/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element: ArithmeticType {
    
    /**
     Sum of elements in Sequence.
     
     >`[1,2,4].sum -> 7`
    */
    public var sum: Iterator.Element { return reduce(Iterator.Element.zero, +) }
    
    /**
     Greatest common divisor of elements in Sequence.
     
     >`[8,12].gcd -> 4`
    */
    public var gcd: Iterator.Element? {
        guard let min = self.min() else { return nil }
        return self.map { greatestCommonDivisor($0, min) }.min()
    }
}
