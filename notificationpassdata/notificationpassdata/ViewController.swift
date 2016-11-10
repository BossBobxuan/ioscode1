//
//  ViewController.swift
//  notificationpassdata
//
//  Created by bossxuan on 16/10/19.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func click() {
        
        performSegueWithIdentifier("aaa", sender: self)
        
       
      
      
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let center = NSNotificationCenter.defaultCenter()
        let notification = NSNotification(name: "text", object: self, userInfo: ["passdata":textField.text!])
        center.postNotification(notification)
    }

}

