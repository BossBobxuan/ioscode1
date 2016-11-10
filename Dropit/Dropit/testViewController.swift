//
//  testViewController.swift
//  Dropit
//
//  Created by bossxuan on 16/10/17.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class testViewController: UIViewController {
    
    @IBOutlet weak var view2: UIView!
    @IBAction func tap(sender: AnyObject) {
        drop()
    }
    var animator : UIDynamicAnimator?
    var behavior = UIGravityBehavior()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: self.view)
        animator!.addBehavior(behavior)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func drop()
    {
        let frame = CGRect(origin: CGPoint(x: self.view.bounds.midX,y: self.view.bounds.midY), size: CGSize(width: self.view.bounds.width/4, height: self.view.bounds.width/4))
        
        let dropView = UIView(frame: frame)
        dropView.backgroundColor = UIColor.blueColor()
        self.view.addSubview(dropView)
        behavior.addItem(dropView)
        
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
