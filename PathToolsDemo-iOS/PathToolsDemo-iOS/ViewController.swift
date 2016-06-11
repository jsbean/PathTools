//
//  ViewController.swift
//  PathToolsDemo-iOS
//
//  Created by James Bean on 6/10/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import UIKit
import PathTools

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let rectanglePath = Path.rectangle(CGRect(x: 400, y: 400, width: 100, height: 100))
//        view.layer.addSublayer(
//            shapeLayer(path: rectanglePath, color: UIColor.redColor().CGColor)
//        )
//        
//        let centerRotatedRectanglePath = rectanglePath.rotated(by: 45)
//        view.layer.addSublayer(
//            shapeLayer(path: centerRotatedRectanglePath, color: UIColor.greenColor().CGColor)
//        )
//        
//        let topLeftRotatedRectanglePath = rectanglePath.rotated(by: 45,
//            around: CGPoint(x: 400, y: 400)
//        )
//        view.layer.addSublayer(
//            shapeLayer(path: topLeftRotatedRectanglePath, color: UIColor.blueColor().CGColor)
//        )
//        
//        let p = Path.parallelogram(
//            center: CGPoint(x: 100, y: 100),
//            height: 10,
//            width: 40,
//            slope: 0.25
//        )
//        view.layer.addSublayer(shapeLayer(path: p))
//        
//        let arrowhead = Path.arrowhead()
//        view.layer.addSublayer(shapeLayer(path: arrowhead))
//        
        let circle = Path.circle(center: CGPoint(x: 400, y: 400), radius: 40)
        //let rectangle = Path.rectangle(CGRect(x: 300, y: 300, width: 200, height: 200))
        //view.layer.addSublayer(shapeLayer(path: rectangle))
        
//        for element in circle {
//            switch element {
//            case .move(let point):
//                
//                
//                //CGPathMoveToPoint(path, nil, point.x, point.y)
//            case .line(let point):
////                CGPathAddLineToPoint(path, nil, point.x, point.y)
//            case .quadCurve(let point, let controlPoint):
////                CGPathAddQuadCurveToPoint(
////                    path, nil,
////                    controlPoint.x, controlPoint.y,
////                    point.x, point.y
////                )
//            case .curve(let point, let controlPoint1, let controlPoint2):
////                CGPathAddCurveToPoint(
////                    path, nil,
////                    controlPoint1.x, controlPoint1.y,
////                    controlPoint2.x, controlPoint2.y,
////                    point.x, point.x
////                )
//            case .close:
//                CGPathCloseSubpath(path)
//            }
//        }

        
        view.layer.addSublayer(shapeLayer(path: circle, color: UIColor.redColor().CGColor))
    }
    
    func shapeLayer(path path: Path, color: CGColorRef = UIColor.blackColor().CGColor)
        -> CAShapeLayer
    {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 1
        shapeLayer.strokeColor = UIColor.grayColor().CGColor
        shapeLayer.fillColor = nil
        //shapeLayer.fillColor = color
        return shapeLayer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

