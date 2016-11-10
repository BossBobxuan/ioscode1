//
//  ViewController.swift
//  Psychologist
//
//  Created by bossxuan on 16/9/25.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         var detination = segue.destinationViewController
        if let ndetination = detination as? UINavigationController{
          detination = ndetination.visibleViewController!
        }
        
        if let hvc = detination as? ViewController
        {
            if let identifier = segue.identifier
            {
                switch identifier {
                case "happy":
                    hvc.happiness = 100
                case "sad":
                    hvc.happiness = 0
                    
                default:
                    hvc.happiness = 50
                }
            }
        }
    }

}

