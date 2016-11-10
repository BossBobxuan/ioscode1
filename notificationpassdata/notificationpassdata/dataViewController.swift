//
//  dataViewController.swift
//  notificationpassdata
//
//  Created by bossxuan on 16/10/19.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class dataViewController: UIViewController {

    @IBOutlet weak var passtextField: UITextField!
    var str : String = "" {
        didSet{
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = NSNotificationCenter.defaultCenter()
        center.addObserverForName("text", object: nil, queue: NSOperationQueue.mainQueue()){ (notification) in
             //let str1 = (notification.userInfo!["passdata"] as! String)
            //print(str1)
            //self.passtextField.text = notification.userInfo!["passdata"] as! String
            self.passtextField.text = (notification.object as! ViewController).textField.text
        }//object表示接收来自哪一个对象的消息空为所有 该闭包异步执行，非顺序执行，在闭包外部的语句会先执行，所以闭包外部更改变量无效
        // Do any additional setup after loading the view.
        print(str)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func click() {
        self.dismissViewControllerAnimated(true, completion: nil)
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
