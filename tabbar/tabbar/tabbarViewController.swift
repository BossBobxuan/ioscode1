//
//  tabbarViewController.swift
//  tabbar
//
//  Created by bossxuan on 16/11/7.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class tabbarViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let image = UIImage(named: "home_74.315018315018px_1200646_easyicon.net")
//        image?.imageWithRenderingMode(.AlwaysOriginal)
//        var tabbar = UITabBarItem(title: nil, image: image, tag: 0)
        self.viewControllers![0].tabBarItem.badgeValue = "fff"
        
//        self.viewControllers![0].tabBarItem = tabbar
        // Do any additional setup after loading the view.
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

}
