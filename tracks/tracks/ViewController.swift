//
//  ViewController.swift
//  tracks
//
//  Created by bossxuan on 16/10/18.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,passValueDelegate {

    /*@IBAction func segue() {
        
        let center = NSNotificationCenter.defaultCenter()
        //let notification = NSNotification(name: "text", object: self, userInfo: ["passdata": newValue.text!])
        //center.postNotification(notification)
        center.postNotificationName("text", object: textField.text!)
        performSegueWithIdentifier("go", sender: self)
    }
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*let center = NSNotificationCenter.defaultCenter()
        let del = UIApplication.sharedApplication().delegate
        center.addObserverForName("sendtext", object: nil, queue: NSOperationQueue.mainQueue()) { (notification) in
            self.textField.text = notification.userInfo!["text"] as? String
        }*/ //object表示希望收到来自谁的通知空为所有人
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 */
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.clearButtonMode = .WhileEditing
    }
    
    @IBAction func buttonAction(sender: AnyObject) {
        let bVC = BViewController()
        
        // 取到闭包传递的值
        bVC.returnNameValue { (name) -> Void in
            self.nameTextField.text = name
        }
        
        // 2、设置代理
        bVC.delegate = self
        
        self.presentViewController(bVC, animated: true, completion: nil)
        
        // 发出广播
        NSNotificationCenter.defaultCenter().postNotificationName("name", object: self.nameTextField.text)
    }
    
    // 3、重写协议方法，取到传值
    func passValue(text: String) {
        textLabel.text = text
    }



}

