//
//  Path+CollisionDetection.swift
//  PathTools
//
//  Created by James Bean on 6/3/17.
//
//

import ArithmeticTools

extension Path {
    
    /// - Warning: Discards Bézier curves
    /// - Warning: Assumes polygon is convex
    public func intersects(_ path: Path) -> Bool {
        return false
    }
    
    public func ys(at x: Double) -> Set<Double> {
        return Set()
    }
    
    public func xs(at y: Double) -> Set<Double> {
        return Set()
    }
    
    /*
 public var description: String { get { return getDescription() } }
    
    public var vertices: [CGPoint] = []
    public var path: UIBezierPath { get { return makePath() } }
    
    public var maxY: CGFloat? { get { return getMaxY() } }
    public var minY: CGFloat? { get { return getMinY() } }
    public var midY: CGFloat? { get { return getMidY() } }
    public var maxX: CGFloat? { get { return getMaxX() } }
    public var minX: CGFloat? { get { return getMinX() } }
    public var midX: CGFloat? { get { return getMidX() } }
    
    init() { }
    
    init(vertices: [CGPoint]) {
        self.vertices = vertices
    }
    
    public func collidesWithPolygon(polygon: Polygon) -> Bool {
        var vertsax: [CGFloat] = []
        var vertsay: [CGFloat] = []
        for point in vertices { vertsax.append(point.x); vertsay.append(point.y) }
        var vertsbx: [CGFloat] = []
        var vertsby: [CGFloat] = []
        for point in polygon.vertices { vertsbx.append(point.x); vertsby.append(point.y) }
        let len_a: Int = vertsax.count
        let len_b: Int = vertsbx.count
        
        // LOOP THROUGH AXES OF SHAPE A
        for j in 0..<len_a - 1 {
            let i = j + 1
            var vx = vertsax[j] - vertsax[i]
            var vy = -(vertsay[j] - vertsay[i])
            let len = sqrt(vx * vx + vy * vy)
            vx /= len
            vy /= len
            
            // PROJECT SHAPE A
            var max0 = vertsax[0] * vx + vertsay[0] * vy
            var min0 = max0
            for k in 1..<len_a {
                let proj_a = vertsax[k] * vx + vertsay[k] * vy
                if proj_a > max0 { max0 = proj_a }
                else if proj_a < min0 { min0 = proj_a }
            }
            
            // PROJECT SHAPE B
            var max1 = vertsbx[0] * vx + vertsby[0] * vy
            var min1 = max1
            for k in 1..<len_b {
                let proj_b = vertsbx[k] * vx + vertsby[k] * vy
                if proj_b > max1 { max1 = proj_b }
                else if proj_b < min1 { min1 = proj_b }
            }
            
            // TEST FOR GAPS
            if !axesOverlap(a0: min0, a1: max0, b0: min1, b1: max1) { return false }
        }
        
        // LOOP THROUGH AXES OF SHAPE B
        for j in 0..<len_b - 1 {
            let i = j + 1
            var vx = vertsbx[j] - vertsbx[i]
            var vy = -(vertsby[j] - vertsby[i])
            let len = sqrt(vx * vx + vy * vy)
            vx /= len
            vy /= len
            
            // PROJECT SHAPE A
            var max0 = vertsax[0] * vx + vertsay[0] * vy
            var min0 = max0
            for k in 1..<len_a {
                let proj_a = vertsax[k] * vx + vertsay[k] * vy
                if proj_a > max0 { max0 = proj_a }
                else if proj_a < min0 { min0 = proj_a }
            }
            
            // PROJECT SHAPE B
            var max1 = vertsbx[0] * vx + vertsby[0] * vy
            var min1 = max1
            for k in 1..<len_b {
                let proj_b = vertsbx[k] * vx + vertsby[k] * vy
                if proj_b > max1 { max1 = proj_b }
                else if proj_b < min1 { min1 = proj_b }
            }
            
            // TEST FOR GAPS
            if !axesOverlap(a0: min0, a1: max0, b0: min1, b1: max1) { return false }
        }
        return true
    }
    
    public func axesOverlap(a0 a0: CGFloat, a1: CGFloat, b0: CGFloat, b1: CGFloat) -> Bool {
        return !(a0 > b1 || b0 > a1)
    }
    
    
    public func containsPoint(point: CGPoint) -> Bool {
        var pointIsInside: Bool = false
        var index0: Int = 0
        while index0 < vertices.count {
            let index1 = (index0 + 1) % vertices.count
            let vertex0 = vertices[index0]
            let vertex1 = vertices[index1]
            let y0_is_greater_than_point_y: Bool = vertex0.y > point.y
            let y1_is_greater_than_point_y: Bool = vertex1.y > point.y
            let run: CGFloat = vertex1.x - vertex0.x
            let rise: CGFloat = vertex1.y - vertex0.y
            let ΔY: CGFloat = point.y - vertex0.y
            let displaceX: CGFloat = vertex0.x
            if (
                y0_is_greater_than_point_y != y1_is_greater_than_point_y &&
                    point.x < (run * ΔY / rise) + displaceX
                )
            {
                pointIsInside = !pointIsInside
            }
            
            index0++
        }
        return pointIsInside
    }
    
    public func getXValuesAtY(y: CGFloat) -> [CGFloat] {
        var values: [CGFloat] = []
        var index0: Int = 0
        while index0 < vertices.count {
            let index1: Int = (index0 + 1) % vertices.count
            var points = [vertices[index0], vertices[index1]]
            points.sortInPlace { $0.y < $1.y }
            let point0 = points[0]
            let point1 = points[1]
            if y >= point0.y && y <= point1.y {
                let ΔY: CGFloat = point1.y - point0.y
                let ΔX: CGFloat = point1.x - point0.x
                if ΔX == 0 { values.appendContentsOf([point0.x, point1.x]) }
                else {
                    let slope: CGFloat = ΔY / ΔX
                    let normalizedY = y - point0.y
                    let x = normalizedY * (1 / slope) + point0.x
                    values.append(x)
                }
            }
            index0++
        }
        return values
    }
    
    public func getYValuesAtX(x: CGFloat) -> [CGFloat] {
        var values: [CGFloat] = []
        var index0: Int = 0
        while index0 < vertices.count {
            let index1: Int = (index0 + 1) % vertices.count
            var points = [vertices[index0],vertices[index1]]
            points.sortInPlace { $0.x < $1.x }
            let point0 = points[0]
            let point1 = points[1]
            if x >= point0.x && x <= point1.x {
                let ΔY: CGFloat = point1.y - point0.y
                let ΔX: CGFloat = point1.x - point0.x
                if ΔX == 0 { values.appendContentsOf([point0.y, point1.y]) }
                else {
                    let slope: CGFloat = ΔY / ΔX
                    let normalizedX = x - point0.x
                    let y = normalizedX * slope + point0.y
                    values.append(y)
                }
                
            }
            index0++
        }
        return values
    }
    
    public func getYValueAtX(x: CGFloat, fromDirection direction: Direction) -> CGFloat {
        var values = getYValuesAtX(x)
        if values.count == 0 { return direction == .North ? minY! : maxY! }
        if direction == .North { values.sortInPlace { $0 < $1 } }
        else { values.sortInPlace { $0 > $1 } }
        return values.first!
    }
    
    public func getXValueAtY(y: CGFloat, fromDirection direction: Direction) -> CGFloat? {
        var values = getXValuesAtY(y)
        if direction == .North { values.sortInPlace { $0 < $1 } }
        else { values.sortInPlace { $0 > $1 } }
        return values.first
    }
    
    internal func makePath() -> UIBezierPath {
        let path: UIBezierPath = UIBezierPath()
        for (index, vertex) in vertices.enumerate() {
            if index == 0 { path.moveToPoint(vertex) }
            else { path.addLineToPoint(vertex) }
        }
        path.closePath()
        return path
    }
    
    internal func getMaxY() -> CGFloat? {
        if vertices.count == 0 { return nil }
        var maxY: CGFloat?
        for vertex in vertices {
            if maxY == nil { maxY = vertex.y }
            else if vertex.y > maxY { maxY = vertex.y }
        }
        return maxY
    }
    
    internal func getMinY() -> CGFloat? {
        if vertices.count == 0 { return nil }
        var minY: CGFloat?
        for vertex in vertices {
            if minY == nil { minY = vertex.y }
            else if vertex.y < minY { minY = vertex.y }
        }
        return minY
    }
    
    internal func getMidY() -> CGFloat? {
        if vertices.count == 0 { return nil }
        return (minY! + maxY!) / 2
    }
    
    internal func getMaxX() -> CGFloat? {
        if vertices.count == 0 { return nil }
        var maxX: CGFloat?
        for vertex in vertices {
            if maxX == nil { maxX = vertex.x }
            else if vertex.x > maxX { maxX = vertex.x }
        }
        return maxX
    }
    internal func getMinX() -> CGFloat? {
        if vertices.count == 0 { return nil }
        var minX: CGFloat?
        for vertex in vertices {
            if minX == nil { minX = vertex.x }
            else if vertex.x < minX { minX = vertex.x }
        }
        return minX
    }
    
    internal func getMidX() -> CGFloat? {
        if vertices.count == 0 { return nil }
        return (minX! + maxX!) / 2
    }
}

extension CALayer {
    
    public func convertY(y: CGFloat, fromLayer otherLayer: CALayer) -> CGFloat {
        let oldPoint: CGPoint = CGPointMake(0, y)
        let newPoint: CGPoint = convertPoint(oldPoint, fromLayer: otherLayer)
        return newPoint.y
    }
    
    public func convertX(x: CGFloat, fromLayer otherLayer: CALayer) -> CGFloat {
        let oldPoint: CGPoint = CGPointMake(x, 0)
        let newPoint: CGPoint = convertPoint(oldPoint, fromLayer: otherLayer)
        return newPoint.x
    }
    
    public func convertPolygon(polygon: Polygon, fromLayer otherLayer: CALayer) -> Polygon {
        var newVertices: [CGPoint] = []
        for vertex in polygon.vertices {
            let newPoint: CGPoint = self.convertPoint(vertex, fromLayer: otherLayer)
            newVertices.append(newPoint)
        }
        return Polygon(vertices: newVertices)
    }
    
    public func convertPolygon(polygon: Polygon, toLayer otherLayer: CALayer) -> Polygon {
        var newVertices: [CGPoint] = []
        for vertex in polygon.vertices {
            let newPoint: CGPoint = self.convertPoint(vertex, toLayer: otherLayer)
            newVertices.append(newPoint)
        }
        return Polygon(vertices: newVertices)
    }
}
 */
}
