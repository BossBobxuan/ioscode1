//
//  ViewController.swift
//  codepassdata
//
//  Created by bossxuan on 16/9/11.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,vcdelegat {
    
    @IBAction func click(sender: UIButton) {
        let sb = UIStoryboard(name:"Main",bundle: nil)
        
        let view = sb.instantiateViewControllerWithIdentifier("123") as! nextViewController
        view.de = self
        view.text = textinput.text!
        self.presentViewController(view, animated: true, completion: {})
        
        
    }
    @IBAction func segueclick(sender: UIButton) {
        
        performSegueWithIdentifier("gogogo", sender: self)
        
    }
    
    @IBOutlet weak var textinput: UITextField!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! nextViewController
        vc.de = self
        vc.text = textinput.text!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getvc(vc:UIViewController)
    {
        textinput.text = (vc as! nextViewController).textout.text
    }


}

