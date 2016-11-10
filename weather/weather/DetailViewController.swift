//
//  DetailViewController.swift
//  weather
//
//  Created by bossxuan on 16/11/6.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var model = locationsub()
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var temLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cityLabel.text = model.title!
        temLabel.text = model.subtitle!
//        backgroundImage.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.75)
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            let imagedata = NSData(contentsOfURL: self.model.iconurl)
            if imagedata != nil
            {
                dispatch_async(dispatch_get_main_queue(), {
                    if let image = UIImage(data: imagedata!)
                    {
                        self.imageView.image = image
                    }
                })
            }
        }
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
