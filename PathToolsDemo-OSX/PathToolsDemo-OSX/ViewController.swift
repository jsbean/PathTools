//
//  ViewController.swift
//  PathToolsDemo-OSX
//
//  Created by James Bean on 6/12/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Cocoa
import PathTools

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewLayer = CALayer()
        view.layer = viewLayer
        view.wantsLayer = true
        
        let square = Path.rectangle(rectangle: CGRect(x: 50, y: 100, width: 100, height: 100))
        let rect = Path.rectangle(rectangle: CGRect(x: 200, y: 100, width: 200, height: 100))
        let circle = Path.circle(center: CGPoint(x: 500, y: 150), radius: 50)
        let ellipse = Path.ellipse(rectangle: CGRect(x: 600, y: 100, width: 200, height: 100))
        
        let shapes = [square, rect, circle, ellipse]
        
        // add original shapes
        shapes.forEach { view.layer!.addSublayer(shapeLayer(path: $0)) }
        
        // transform shapes
        shapes.map { $0.rotated(by: 45) }
            .map { $0.translated(verticallyBy: 200) }
            .forEach { view.layer!.addSublayer(shapeLayer(path: $0)) }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    func shapeLayer(path path: Path, color: CGColorRef = CGColorCreateGenericRGB(1, 0, 0, 1))
        -> CAShapeLayer
    {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 1
        shapeLayer.strokeColor = CGColorCreateGenericRGB(1, 0, 0, 1)
        shapeLayer.fillColor = nil
        return shapeLayer
    }
}

