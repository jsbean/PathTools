//
//  BezierCurveSolver.swift
//  PathTools
//
//  Created by James Bean on 6/10/17.
//
//

import GeometryTools

protocol BezierCurveSolver {
    func ts(for value: Double, on axis: Axis) -> Set<Double>
}
