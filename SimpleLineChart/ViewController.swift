//
//  ViewController.swift
//  SimpleLineChart
//
//  Created by Flávio Silvério on 10/08/16.
//  Copyright © 2016 Flávio Silvério. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var lineChart: SimpleLineChart!
    @IBOutlet weak var generateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        lineChart.delegate = self
        lineChart.maximumZoomScale = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func generate(_ sender: AnyObject) {
        
        lineChart.clear()
        lineChart.values = getValues()
        lineChart.drawGraph()


    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return (scrollView as! SimpleLineChart).contentView
    }
    
    func getValues() -> [CGFloat]{
        let totalNumbers = Int(arc4random_uniform(10)) + 3
        var array : [CGFloat] = []
        repeat {
            
            array.append(CGFloat(arc4random_uniform(UInt32(100.0))))
            
        } while (array.count < totalNumbers)
        print(array)
        return array
    }
    
}

