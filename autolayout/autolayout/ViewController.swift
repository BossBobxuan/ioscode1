//
//  ViewController.swift
//  autolayout
//
//  Created by bossxuan on 16/10/4.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    var secure = false {didSet{updateUI()}}
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateUI()
    }
    @IBAction func login() {
        updateUI()
    }
    @IBAction func securechange() {
        secure = !secure
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    private func updateUI() ->Void {
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "securepassword" : "password"
        nameLabel.text = loginField.text
        if loginField.text == "123"
        {
            companyLabel.text = "ddd"
            images.image = UIImage(named: "photo")
        }else{
            companyLabel.text = "ffffffffffffffff"
            images.image = UIImage(named: "photo2")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

