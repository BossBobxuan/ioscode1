//
//  nextViewController.swift
//  test2
//
//  Created by bossxuan on 16/9/9.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit
protocol nextdelegate {
    func passdata(control:nextViewController) -> Void
}

class nextViewController: UIViewController {
    var textx:model?
    var delegate:nextdelegate?
    
    @IBOutlet weak var textout: UITextField!
    
    @IBAction func clickon(sender: UIButton) {
        //self.delegate?.passdata(self);
        textx!.tt = textout.text!
        self.dismissViewControllerAnimated(true, completion: {})
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textout.text=textx?.tt;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
