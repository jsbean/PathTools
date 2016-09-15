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
            let bounds = cgPath.boundingBox
            return CGPoint(x: bounds.midX, y: bounds.midY)
        }
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: pointRef.x, y: pointRef.y)
        transform = transform.rotated(by: DEGREES_TO_RADIANS(degrees))
        transform = transform.translatedBy(x: -pointRef.x, y: -pointRef.y)
        return Path(cgPath.copy(using: &transform)!)
    }
    
    /**
     - returns: `Path` that is scaled by the given `amount`.
     */
    public func scaled(by amount: CGFloat) -> Path {
        var scale = CGAffineTransform(scaleX: amount, y: amount)
        let beforeBounds = cgPath.boundingBox
        let beforeCenter = CGPoint(x: beforeBounds.midX, y: beforeBounds.midY)
        let newPath = cgPath.copy(using: &scale)
        let afterBounds = cgPath.boundingBox
        let afterCenter = CGPoint(x: afterBounds.midX, y: afterBounds.midY)
        let ΔY: CGFloat = -(afterCenter.y - beforeCenter.y)
        let ΔX: CGFloat = -(afterCenter.x - beforeCenter.x)
        var backToCenter = CGAffineTransform(translationX: ΔX, y: ΔY)
        return Path(newPath!.copy(using: &backToCenter))
    }
    
    /**
     - returns: `Path` translated by the given amounts.
     */
    public func translated(horizontallyBy tx: CGFloat = 0, verticallyBy ty: CGFloat = 0)
        -> Path
    {
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: tx, y: ty)
        return Path(cgPath.copy(using: &transform))
    }

    /**
     - returns: `Path` that is mirrored over the y-axis.
     */
    public func mirroredVertical() -> Path {
        var transform = CGAffineTransform.identity
        transform = CGAffineTransform(scaleX: -1, y: 1)
        transform = CGAffineTransform(translationX: cgPath.boundingBox.width, y: 0)
        return Path(cgPath.copy(using: &transform))
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
