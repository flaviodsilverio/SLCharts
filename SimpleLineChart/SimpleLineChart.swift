//
//  SimpleLineChart.swift
//  SimpleLineChart
//
//  Created by Flávio Silvério on 10/08/16.
//  Copyright © 2016 Flávio Silvério. All rights reserved.
//

import UIKit

class SimpleLineChart: UIScrollView {

    var objects : [AnyObject] = []
    var values : [CGFloat] = []

    private var max : Int = 0
    private var min : Int = 0
    
    let contentView = UIView()
    
    func drawGraph(){
        
        contentView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.frame.size)
        self.addSubview(contentView)
        
        normalize()
        
        var points : [CGPoint] = []
        
        let totalPoints = CGFloat(values.count + 1)
        
        for i in 0...values.count - 1 {
            
            let currentX = CGFloat(i + 1) * self.frame.width / totalPoints
            let currentY = self.frame.height * (values[i] / CGFloat(max))
            
            points.append(CGPoint(x: currentX, y: currentY))
            
            contentView.addSubview(makeData(point: points.last!))
            
        }
        
        createPathAndAnimationWith(points: points)

    }
    
    func createPathAndAnimationWith(points: [CGPoint]){
        
        let path = UIBezierPath()
        path.move(to: points.first!)
        
        for i in 1...points.count - 1 {
            path.addLine(to: points[i])
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 1.0
        contentView.layer.addSublayer(shapeLayer)
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 3.0
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        shapeLayer.add(pathAnimation, forKey: "strokeEnd")
        
    }
    
    func normalize(){
    
        max = Int(values.max()!)
        min = Int(values.min()!)
        
        while max % 10 != 0 {
            max += 1
        }
        
        while (min % 10 != 0) || (min > 0) {
            min -= 1
        }
        
        min = 0//min < 0 ? 0.0 : min
        
    }
    
    func clear(){
        for v in self.contentView.subviews {
            v.removeFromSuperview()
        }
        if self.contentView.layer.sublayers?.count > 0 {
            
            for l in self.contentView.layer.sublayers! {
                l.removeFromSuperlayer()
            }
        }
    }
    
    func makeData(point: CGPoint) -> UIButton{
        
        let button = UIButton(frame: CGRect(x: point.x - 3, y: point.y - 3, width: 6, height: 6))
        button.backgroundColor = UIColor.green
        button.layer.cornerRadius = button.frame.height / 2
        return button
        
    }
}
