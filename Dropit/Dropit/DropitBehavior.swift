//
//  DropitBehavior.swift
//  Dropit
//
//  Created by bossxuan on 16/10/17.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class DropitBehavior: UIDynamicBehavior {
    let gravity = UIGravityBehavior()
    
    lazy var collider : UICollisionBehavior =  {
        let ccc = UICollisionBehavior()
        ccc.translatesReferenceBoundsIntoBoundary = true
        return ccc
    }()
    lazy var dropBehavior : UIDynamicItemBehavior = {
        let db = UIDynamicItemBehavior()
        db.allowsRotation = false
        db.elasticity = 0
        return db
    }()
    override init() {
        super.init()
        addChildBehavior(dropBehavior)
        addChildBehavior(gravity)
        addChildBehavior(collider)
    }
    func addDrop(drop: UIView)  {
        dynamicAnimator?.referenceView?.addSubview(drop)
        gravity.addItem(drop)
        collider.addItem(drop)
        dropBehavior.addItem(drop)
    }
    func removeDrop(drop: UIView)  {
        gravity.removeItem(drop)
        collider.removeItem(drop)
        dropBehavior.removeItem(drop)
        drop.removeFromSuperview()
    }
}
