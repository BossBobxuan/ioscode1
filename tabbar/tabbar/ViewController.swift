//
//  ViewController.swift
//  tabbar
//
//  Created by bossxuan on 16/11/7.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBAction func change(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0
        {
            label.hidden = true
            button.hidden = false
        }
        else
        {
            label.hidden = false
            button.hidden = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        segment.selectedSegmentIndex = 1
//        label.hidden = true
//        button.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

