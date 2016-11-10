//
//  ViewController.swift
//  caculator
//
//  Created by bossxuan on 16/9/10.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var number:Double = 0;
    var currentnumber :Double = 0
    var type : String = "";
    @IBOutlet weak var textinput: UITextField!
    @IBAction func numberclick(sender: UIButton) {
        if (textinput.text == "+" || textinput.text == "-" || textinput.text == "*" || textinput.text == "/"  )
        {
            textinput.text = ""
        }
        if (sender.currentTitle == ".")
        {
            if (textinput.text == "")
            {
                textinput.text = "0"
            }
        }
       
        textinput.text = textinput.text! + sender.currentTitle!
    }
    @IBAction func deletestr(sender: UIButton) {
        if (textinput.text != "")
        {
            let count = textinput.text!.characters.count - 1
            textinput.text = textinput.text!.substringToIndex(textinput.text!.startIndex.advancedBy(count));
        }
    }
    @IBAction func add(sender: UIButton) {
        currentnumber =  (textinput.text! as NSString).doubleValue
        textinput.text = "+"
        type = sender.currentTitle!
    }
    @IBAction func sub(sender: UIButton) {
        currentnumber =   (textinput.text! as NSString).doubleValue
        textinput.text = "-"
        type = sender.currentTitle!
        
    }
    @IBAction func multi(sender: UIButton) {
        currentnumber = (textinput.text! as NSString).doubleValue
        textinput.text = "+"
        type = sender.currentTitle!
    }
    @IBAction func div(sender: UIButton) {
        currentnumber = (textinput.text! as NSString).doubleValue
        textinput.text = "/"
        type = sender.currentTitle!
    }
    @IBAction func equal(sender: UIButton) {
        switch type {
        case "+":
            number =  currentnumber + (textinput.text! as NSString).doubleValue
            textinput.text = "\(number)"
            
        case "-":
            number =  currentnumber - (textinput.text! as NSString).doubleValue
            textinput.text = "\(number)"
        case "*":
            number =  currentnumber * (textinput.text! as NSString).doubleValue
            textinput.text = "\(number)"
        case "/":
            number =  currentnumber / (textinput.text! as NSString).doubleValue
            textinput.text = "\(number)"
        default:
            textinput.text = "error"
        }
    }
    @IBAction func resetclick(sender: UIButton) {
        textinput.text = ""
        number = 0
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

