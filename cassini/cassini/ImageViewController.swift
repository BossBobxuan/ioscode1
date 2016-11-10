//
//  ImageViewController.swift
//  cassini
//
//  Created by bossxuan on 16/10/5.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController,UIScrollViewDelegate {
    private var imageView = UIImageView()
    private var image : UIImage?
        {set{imageView.image = newValue
            imageView.sizeToFit()
            ScrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
            print("a")
        }
        get{return imageView.image}}
    var imageURL :NSURL?
        {
        didSet{
            image = nil
            if view.window != nil{
            fetchImage()
            }
        }
        }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    @IBOutlet weak var ScrollView: UIScrollView!
        {didSet{
            ScrollView.contentSize = imageView.frame.size
            ScrollView.delegate = self
            ScrollView.minimumZoomScale = 0.03
            ScrollView.maximumZoomScale = 2
        
        }}
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    func fetchImage(){
        if let url = imageURL{
            spinner.startAnimating()
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)){()-> Void in
            let imageData = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()){() -> Void in
                    if url == self.imageURL{
                        
            if imageData != nil{
                
                self.image = UIImage(data: imageData!)
            }else{
                self.image = nil
                        }}}}
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil{
            fetchImage()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScrollView.addSubview(imageView)
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
