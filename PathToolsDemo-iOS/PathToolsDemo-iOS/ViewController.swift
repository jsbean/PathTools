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
        
        let square = Path.rectangle(rectangle: CGRect(x: 50, y: 100, width: 100, height: 100))
        let rect = Path.rectangle(rectangle: CGRect(x: 200, y: 100, width: 200, height: 100))
        
        square.append(rect)
        
        view.layer.addSublayer(shapeLayer(path: square))
        
        
//        let circle = Path.circle(center: CGPoint(x: 500, y: 150), radius: 50)
//        let ellipse = Path.ellipse(rectangle: CGRect(x: 600, y: 100, width: 200, height: 100))
//        
//        let shapes = [square, rect, circle, ellipse]
//        
//        shapes.forEach { view.layer.addSublayer(shapeLayer(path: $0)) }
//        shapes.map { $0.rotated(by: 45) }
//            .map { $0.translated(verticallyBy: 200) }
//            .forEach { view.layer.addSublayer(shapeLayer(path: $0)) }
    }
    
    func shapeLayer(path: Path, color: CGColor = UIColor.black.cgColor)
        -> CAShapeLayer
    {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 1
        shapeLayer.strokeColor = UIColor.darkGray.cgColor
        shapeLayer.fillColor = UIColor.lightGray.cgColor
        return shapeLayer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

