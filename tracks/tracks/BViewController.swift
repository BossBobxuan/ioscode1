//
//  codeViewController.swift
//  tracks
//
//  Created by bossxuan on 16/10/19.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

/*class BViewController: UIViewController {

    @IBAction func click() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = NSNotificationCenter.defaultCenter()
        //center.addObserverForName("text", object: nil, queue: NSOperationQueue.mainQueue()){ (notification) in
          //  self.text.text = notification.userInfo!["passdata"] as? String
        //}
        // Do any additional setup after loading the view.
        center.addObserver(self, selector: "change:", name: "text", object: nil)
    }
    func change(notification: NSNotification) -> Void {
        print(notification.object as! String)
         self.text.text = notification.object as? String
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
 
    

}*/
protocol passValueDelegate {
    func passValue( text: String)
}


typealias nameValue = (String)->Void

class BViewController: UIViewController {
    // 1、声明属性
    var delegate: passValueDelegate?
    
    
    @IBOutlet weak var bNameTextField: UITextField!
    
    var nameText: nameValue?
    
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        bNameTextField.clearButtonMode = .WhileEditing
        textField.clearButtonMode = .WhileEditing
        
        // 注册为观察者，接收信息
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "printName:", name: "name", object: nil)
    }
    
    @IBAction func buttonActive(sender: AnyObject) {
        // 2、调用代理方法，把值传输出去
        self.delegate?.passValue(textField.text!)
        
        // 使用闭包传值出去
        self.nameText!(self.bNameTextField.text!)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func printName(notifaction: NSNotification) {
        print(notifaction.object)
        bNameTextField.text = notifaction.object as? String
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // 闭包方法
    func returnNameValue(name: nameValue) {
        self.nameText = name
    }
}
