//
//  childViewController.swift
//  Psychologist
//
//  Created by bossxuan on 16/10/2.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class childViewController: ViewController,UIPopoverPresentationControllerDelegate {
    var history : [Double]{
        set{defaults.setObject(newValue, forKey: "history")}
        get{return defaults.objectForKey("history") as? [Double] ?? []}
    
    }

    override var happiness: Double  {didSet{
            history.append(happiness)
        }}
    let defaults = NSUserDefaults.standardUserDefaults()
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nvc  = segue.destinationViewController as? TextViewController
        {
            if let ppc = nvc.popoverPresentationController
            {
                ppc.delegate = self
            }
            nvc.text = "\(history)"
        }
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
