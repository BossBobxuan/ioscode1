//
//  UnwindViewController.swift
//  Smashtag
//
//  Created by bossxuan on 16/10/10.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class UnwindViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var textField: UITextField!

    @IBAction func animation() {
        UIView.transitionWithView(self.view, duration: 2, options: .TransitionFlipFromLeft, animations: {}, completion:{if $0 {}})
    }
    
    // MARK: - Navigation

 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "go"{
        if let bvc = segue.destinationViewController as? ViewController{
                bvc.text = textField.text!
            }
        }
    }
 

}
