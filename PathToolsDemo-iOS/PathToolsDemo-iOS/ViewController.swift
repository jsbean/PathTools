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
        
        let rect = CGRect(x: 100, y: 100, width: 200, height: 200)
        let rectPath = Path(rect)
        let rectShape = CAShapeLayer()
        rectShape.path = rectPath.cgPath
        rectShape.fillColor = UIColor.blackColor().CGColor
        view.layer.addSublayer(rectShape)
        
        
//        var path = Path()
//        path.move(to: CGPoint(x: 100, y: 100))
//        path.addLine(to: CGPoint(x: 200, y: 200))
//        
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = path.cgPath
//        
//        shapeLayer.strokeColor = UIColor.blackColor().CGColor
//        
//        var newPath = Path()
//        newPath.move(to: CGPoint(x: 200, y: 200))
//        newPath.addQuadCurve(to: CGPoint(x: 400, y: 100), controlPoint: CGPoint(x: 100, y: 20))
//        newPath.addCurve(
//            to: CGPoint(x: 600, y: 600),
//            controlPoint1: CGPoint(x: 500, y: 50),
//            controlPoint2: CGPoint(x: 300, y: 20)
//        )
//        
//        let newShapeLayer = CAShapeLayer()
//        newShapeLayer.path = newPath.cgPath
//        
//        newShapeLayer.strokeColor = UIColor.blackColor().CGColor
//        
//        view.layer.addSublayer(shapeLayer)
//        view.layer.addSublayer(newShapeLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

