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
        
        var rectanglePath = Path.rectangle(CGRect(x: 400, y: 400, width: 100, height: 100))
        rectanglePath = rectanglePath.rotated(by: 45)
        view.layer.addSublayer(shapeLayer(path: rectanglePath))
        
        let p = Path.parallelogram(
            center: CGPoint(x: 100, y: 100),
            height: 10,
            width: 40,
            slope: 0.25
        )
        view.layer.addSublayer(shapeLayer(path: p))
    }
    
    func shapeLayer(path path: Path) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.blackColor().CGColor
        return shapeLayer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

