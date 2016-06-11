//
//  Path+Transform.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import QuartzCore

extension Path {
    
    // MARK: - Transforms
    
    /**
     - returns: `Path` that is rotated by the given `degrees`, around the given `point`. 
     If `point` is `nil`, the center of the the bounding box is chosen.
     */
    public func rotated(by degrees: Degrees, around point: CGPoint? = nil) -> Path {
        var pointRef: CGPoint {
            if let point = point { return point }
            let bounds = CGPathGetBoundingBox(cgPath)
            return CGPoint(x: bounds.midX, y: bounds.midY)
        }
        var transform = CGAffineTransformIdentity
        transform = CGAffineTransformTranslate(transform, pointRef.x, pointRef.y)
        transform = CGAffineTransformRotate(transform, DEGREES_TO_RADIANS(degrees))
        transform = CGAffineTransformTranslate(transform, -pointRef.x, -pointRef.y)
        return Path(CGPathCreateCopyByTransformingPath(cgPath, &transform)!)
    }
    
    /**
     - returns: `Path` that is scaled by the given `amount`.
     */
    public func scaled(by amount: CGFloat) -> Path {
        var scale = CGAffineTransformMakeScale(amount, amount)
        let beforeBounds = CGPathGetBoundingBox(cgPath)
        let beforeCenter = CGPointMake(CGRectGetMidX(beforeBounds), CGRectGetMidY(beforeBounds))
        let newPath = CGPathCreateCopyByTransformingPath(cgPath, &scale)
        let afterBounds = CGPathGetBoundingBox(cgPath)
        let afterCenter = CGPointMake(CGRectGetMidX(afterBounds), CGRectGetMidY(afterBounds))
        let ΔY: CGFloat = -(afterCenter.y - beforeCenter.y)
        let ΔX: CGFloat = -(afterCenter.x - beforeCenter.x)
        var backToCenter = CGAffineTransformMakeTranslation(ΔX, ΔY)
        return Path(CGPathCreateCopyByTransformingPath(newPath, &backToCenter))
    }
    
    /**
     - returns: `Path` translated by the given amounts.
     */
    public func translated(horizontallyBy tx: CGFloat = 0, verticallyBy ty: CGFloat = 0)
        -> Path
    {
        var transform = CGAffineTransformIdentity
        transform = CGAffineTransformTranslate(transform, tx, ty)
        return Path(CGPathCreateCopyByTransformingPath(cgPath, &transform))
    }

    /**
     - returns: `Path` that is mirrored over the y-axis.
     */
    public func mirroredVertical() -> Path {
        var transform = CGAffineTransformIdentity
        transform = CGAffineTransformMakeScale(-1, 1)
        transform = CGAffineTransformMakeTranslation(CGPathGetBoundingBox(cgPath).width, 0)
        return Path(CGPathCreateCopyByTransformingPath(cgPath, &transform))
    }
    
    /**
     - warning: Not yet implemented!
     */
    public func mirroredHorizontal() -> Path {
        fatalError()
    }
}
//
//public func mirror() {
//    let mirrorOverXOrigin = CGAffineTransformMakeScale(-1, 1)
//    let translate = CGAffineTransformMakeTranslation(bounds.width, 0)
//    self.applyTransform(mirrorOverXOrigin)
//    self.applyTransform(translate)
//}
//
//public func scale(sx: CGFloat, sy: CGFloat) {
//    let scale = CGAffineTransformMakeScale(sx, sy)
//    let beforeBounds = CGPathGetBoundingBox(self.CGPath)
//    let beforeCenter = CGPointMake(CGRectGetMidX(beforeBounds), CGRectGetMidY(beforeBounds))
//    self.applyTransform(scale)
//    let afterBounds = CGPathGetBoundingBox(self.CGPath)
//    let afterCenter = CGPointMake(CGRectGetMidX(afterBounds), CGRectGetMidY(afterBounds))
//    let ΔY: CGFloat = -(afterCenter.y - beforeCenter.y)
//    let ΔX: CGFloat = -(afterCenter.x - beforeCenter.x)
//    let backToCenter = CGAffineTransformMakeTranslation(ΔX, ΔY)
//    self.applyTransform(backToCenter)
//}