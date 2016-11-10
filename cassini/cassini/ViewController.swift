//
//  ViewController.swift
//  cassini
//
//  Created by bossxuan on 16/10/5.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nvc = segue.destinationViewController as? ImageViewController
        {
            if let identifier = segue.identifier
            {
                switch identifier {
                case "76ers":
                nvc.imageURL = DemoURL.NBA.p76ers
                    nvc.title = identifier
                case "can":
                nvc.imageURL = DemoURL.NBA.Caverliers
                    nvc.title = identifier
                case "Heat":
                nvc.imageURL = DemoURL.NBA.Heat
                    nvc.title = identifier
                default:
                    break
                }
            }
        }
    }

}

