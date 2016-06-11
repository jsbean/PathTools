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
        
        let circle = Path.circle(center: CGPoint(x: 400, y: 400), radius: 100)
        let circleShape = CAShapeLayer()
        circleShape.path = circle.cgPath
        circleShape.fillColor = UIColor.redColor().CGColor
        view.layer.addSublayer(circleShape)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

