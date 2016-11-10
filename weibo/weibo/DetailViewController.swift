//
//  DetailViewController.swift
//  weibo
//
//  Created by bossxuan on 16/11/8.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UIWebViewDelegate {

    let baseurl : String = "https://m.baidu.com/s?ie=UTF-8&tn=null&wd="
    var url :String? 

    @IBOutlet weak var webView: UIWebView!
        {didSet{webView.delegate = self}}

    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let url1 = url
        {
            webView.loadRequest(NSURLRequest(URL: NSURL(string: baseurl + url1)!))
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        webView.stopLoading()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }


}

