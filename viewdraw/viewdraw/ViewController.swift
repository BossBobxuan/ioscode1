//
//  ViewController.swift
//  viewdraw
//
//  Created by bossxuan on 16/9/16.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,passdatadelegate {
    @IBOutlet  weak var faceView: drawview!
        {
        didSet{
            faceView.delegate = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
            
        }
    }
    @IBAction func happinesschange(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Ended:
            fallthrough
        case .Changed:
            let happinesschange = Double(-sender.translationInView(faceView).y/4)
            if happinesschange != 0
            {
                happiness = happiness + happinesschange
                sender.setTranslation(CGPointZero, inView: faceView)
            }
        default:
            break
        }
    }
        var happiness : Double = 0 {
        didSet{
            
            happiness = min(max(happiness,0),100)
            UIupdate()
            title = "\(happiness)"
        }}
    func UIupdate() -> Void {
        faceView?.setNeedsDisplay()
    }
    func passdata() -> Double {
        return (happiness - 50) / 50
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

