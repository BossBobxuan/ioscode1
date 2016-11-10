//
//  ViewController.swift
//  test2
//
//  Created by bossxuan on 16/9/9.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,nextdelegate {
    var str : model = model() {didSet{textin?.text = str.tt}}
    @IBOutlet weak var textin: UITextField!
   func passdata(control: nextViewController) {
//        textin.text = control.textout.text!;
   }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let view:nextViewController = segue.destinationViewController as! nextViewController;
        view.delegate = self;
        str.tt = textin.text!
        view.textx = self.str;
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

