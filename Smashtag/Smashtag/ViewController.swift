//
//  ViewController.swift
//  Smashtag
//
//  Created by bossxuan on 16/10/7.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func goback(segue: UIStoryboardSegue){
          print("goback")
        print(text)
    }
    @IBOutlet weak var textfield: UITextField!
    var alert: UIAlertController = UIAlertController(title: "ccc", message: "ddd", preferredStyle: UIAlertControllerStyle.ActionSheet)
    var alert2 = UIAlertController(title: "bbb", message: "login", preferredStyle: .Alert)
    
    @IBAction func showalert() {
        presentViewController(alert, animated: true, completion: {})
    }
    var text:String = ""
        {
            didSet{
                textfield.text = text
            }
    }
    var isstart : Bool = true
    var timer : NSTimer?
    @IBAction func showalert2() {
        //presentViewController(alert2, animated: true, completion: {})
         UIView.transitionWithView(self.Label, duration: 2, options: .TransitionCrossDissolve, animations: {self.Label.hidden = true}, completion: {(Bool)->Void in})
        if !isstart{
            timer?.fireDate = NSDate.distantPast()//启动定时器
            isstart = true}
        else if timer != nil {
        
                timer!.fireDate = NSDate.distantFuture()//关闭定时器 随机访问一个未来的时间
                isstart = false
        }
    }
    
    @IBOutlet weak var alerts: UIBarButtonItem!
    var time: Int = 0
    @IBOutlet weak var Label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Label.hidden = false
        alert.addAction(UIAlertAction(title: "fff", style: UIAlertActionStyle.Default)
        {(handler:UIAlertAction)-> Void in })
        alert.addAction(UIAlertAction(title: "cancel", style: .Cancel){(action:UIAlertAction)->Void in})
        
        alert2.addAction(UIAlertAction(title: "login", style: .Default){(action:UIAlertAction)->Void in
             let Field = self.alert2.textFields?[1] as UITextField?
            if Field != nil{
                self.text = Field!.text!
            }
            })
        let a : Int = 5
        //alert2.addAction(UIAlertAction(title: "cancel", style: .Cancel){(action:UIAlertAction)->Void in})
        alert2.addAction(UIAlertAction(title: "cancel1", style: .Default){(action:UIAlertAction)->Void in})
        alert2.addTextFieldWithConfigurationHandler{(TextField: UITextField) in TextField.placeholder = "123"}
        alert2.addTextFieldWithConfigurationHandler{(TextField: UITextField) in TextField.placeholder = "222"}
        alert.modalPresentationStyle = .Popover
        let ppc = alert.popoverPresentationController
        ppc?.barButtonItem = alerts
           timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "fire:", userInfo: a, repeats: true) //target要传送的目标 selector方法名有冒号表示传递参数 userINfo 可以传入对象在方法中通过timer.userInfo获取用于传递数据
        UIView.animateWithDuration(3, delay: 2, options: .CurveEaseInOut, animations:
            { self.textfield.alpha = 0}, completion: {(Bool)->Void in })
        //UIView.animateWithDuration(3, delay: 1, options: .CurveEaseInOut, animations:
         //   { self.Label.alpha = 0}, completion: {(Bool)->Void in })
       
        
      
    }
    func  fire(timer:NSTimer) -> Void {
        var b = timer.userInfo as! Int
        time = b + 1
        
        Label.text = "\(time)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

