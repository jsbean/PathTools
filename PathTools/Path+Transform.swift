//
//  Path+Transform.swift
//  PathTools
//
//  Created by James Bean on 6/11/16.
//
//

import QuartzCore

extension Path {
    
    /**
     - warning: Not yet implemented!
     */
    public func rotated(by degrees: CGFloat) -> Path {
        fatalError()

        //CGPathCreateCopyByTransformingPath(cgPath, <#T##transform: UnsafePointer<CGAffineTransform>##UnsafePointer<CGAffineTransform>#>)
        
        // use internal bounding box ?
//        let bounds = CGPathGetBoundingBox(cgPath)
//        let center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds))
//        let toOrigin = CGAffineTransformMakeTranslation(-center.x, -center.y)
//        
//        let rotation = CGAffineTransformMakeRotation(CGFloat(DEGREES_TO_RADIANS(degrees)))
//        let fromOrigin = CGAffineTransformMakeTranslation(center.x, center.y)
//        
//
//        self.applyTransform(toOrigin)
//        self.applyTransform(rotation)
//        self.applyTransform(fromOrigin)
    }
    
    /**
     - warning: Not yet implemented!
     */
    public func scaled(by amount: CGFloat) -> Path {
        fatalError()
    }

    /**
     - warning: Not yet implemented!
     */
    public func mirroredVertical() -> Path {
        fatalError()
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