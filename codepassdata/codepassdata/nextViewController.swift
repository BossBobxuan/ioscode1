//
//  nextViewController.swift
//  codepassdata
//
//  Created by bossxuan on 16/9/11.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit
protocol vcdelegat {
    func getvc(vc:UIViewController)->Void
}

class nextViewController: UIViewController {
    var text:String = ""
    var de:vcdelegat?
    @IBOutlet weak var textout: UITextField!

    @IBAction func goback(sender: UIButton) {
        de!.getvc(self)
        self.dismissViewControllerAnimated(true, completion: {})
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if (text != "")
        {
            textout.text = text
        }
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
