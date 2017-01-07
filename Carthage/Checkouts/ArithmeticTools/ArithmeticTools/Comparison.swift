//
//  Comparison.swift
//  ArithmeticTools
//
//  Created by James Bean on 5/11/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

public enum Comparison {
    case equal
    case lessThan
    case greaterThan
}

public func compare<T: Comparable>(_ a: T, _ b: T) -> Comparison {
    return a < b ? .lessThan : a > b ? .greaterThan : .equal
}
