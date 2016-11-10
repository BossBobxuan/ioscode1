//
//  ViewController.swift
//  quiz
//
//  Created by bossxuan on 16/11/9.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class quizViewController: UIViewController {

    @IBAction func submitGuess(sender: UISegmentedControl)
    {
        
    }
    @IBOutlet var segmentdController: [UISegmentedControl]!
    @IBOutlet weak var AnswerLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var flagimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

