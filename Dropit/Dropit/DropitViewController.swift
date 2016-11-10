//
//  ViewController.swift
//  Dropit
//
//  Created by bossxuan on 16/10/13.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit
private extension CGFloat {
    static func random(max: Int) ->CGFloat{
        return CGFloat(arc4random() % UInt32(max))
    }
}
private extension UIColor{
    class var random : UIColor{
        switch arc4random()%5 {
        case 0: return UIColor.greenColor()
        case 1: return UIColor.blueColor()
        case 2: return UIColor.orangeColor()
        case 3: return UIColor.redColor()
        case 4: return UIColor.purpleColor()
        default: return UIColor.blackColor()
        }
    }
}
class DropitViewController: UIViewController,UIDynamicAnimatorDelegate {
    
    /*lazy var animator : UIDynamicAnimator = {
        let ddd = UIDynamicAnimator(referenceView: self.gameView)
        return ddd
    }()*/
    let DropBehavior : DropitBehavior = DropitBehavior()
    var animator : UIDynamicAnimator?
    
    
    @IBOutlet weak var gameView: UIView!
    var dropsPerRow = 10
    var dropSize : CGSize {
        let size = gameView.bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }//计算属性做只读时可以省略get直接在其后加大括号
    @IBAction func drop(sender: AnyObject) {
        drop()
    }
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        removeCompletedRow()
    }
    func drop(){
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        
        let dropView   = UIView(frame:frame)
        dropView.backgroundColor = UIColor.random
        DropBehavior.addDrop(dropView)
    }
    func removeCompletedRow()
    {
        var dropsToRemove = [UIView]()
        var t:CGFloat = 0
        var dropFrame = CGRect(x: 0, y: gameView.frame.maxY, width: dropSize.width, height: dropSize.height)
        repeat
        {
            t = 0
            dropFrame.origin.y -= dropSize.height
            dropFrame.origin.x = 0
            var dropsFound = [UIView]()
            var rowIsComplete = true
            for _ in 0..<dropsPerRow
            {
                if let hitView = gameView.hitTest(CGPoint(x: dropFrame.midX+t, y: dropFrame.midY), withEvent: nil)
                {
                    if hitView.superview == gameView
                    {
                        dropsFound.append(hitView)
                    }
                    else
                    {
                        rowIsComplete = false
                    }
                }
                t += dropSize.width
            }
            if rowIsComplete
            {
                dropsToRemove += dropsFound
            }
                
            
        } while dropsToRemove.count == 0 && dropFrame.origin.y > 0
        for drop in dropsToRemove
        {
           DropBehavior.removeDrop(drop)
        }
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let animator : UIDynamicAnimator  = UIDynamicAnimator(referenceView: gameView)
        
        animator = UIDynamicAnimator(referenceView: gameView)
        animator?.delegate = self
        animator?.addBehavior(DropBehavior)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

