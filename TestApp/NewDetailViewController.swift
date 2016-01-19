//
//  ViewController.swift
//  browser
//
//  Created by pzyyll on 15/12/11.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import UIKit

class New2DetailViewController: UIViewController, UIWebViewDelegate {

    var webView: UIWebView?
    var toolBar: UIToolbar?
    
    var reloadBtn : UIBarButtonItem?
    var forwardBtn : UIBarButtonItem?
    var backBtn : UIBarButtonItem?
    var stopBtn : UIBarButtonItem?
    
    var url: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
    
        //1.配置
        var rect = CGRectMake(0, 64, self.view.bounds.width, self.view.bounds.height - 44)
        self.webView = UIWebView(frame: rect)
        self.webView?.scalesPageToFit = true //自适应
        self.view.addSubview(self.webView!)
        
        rect = CGRectMake(0, self.view.bounds.height - 44, self.view.bounds.width, 30)
        self.toolBar = UIToolbar(frame: rect)
        self.toolBar?.backgroundColor = UIColor.darkGrayColor()
        
        reloadBtn = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: Selector("reloadWeb"))
        //let icon = UIImage(named: "forward");
        forwardBtn = UIBarButtonItem(title: "前进", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("forwardWeb"))
        //forwardBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem, target: self, action: Selector("forwardWeb"))
        backBtn = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("backWeb"))
        stopBtn = UIBarButtonItem(barButtonSystemItem: .Stop, target: self, action: Selector("stopWeb"))
        let filSpaceBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        self.toolBar?.setItems([reloadBtn!,filSpaceBtn,forwardBtn!, filSpaceBtn,backBtn!, filSpaceBtn,stopBtn!], animated: true)
        self.view.addSubview(self.toolBar!)
        
        self.webView?.delegate = self
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let request = NSURLRequest(URL: url!)
        
        self.webView?.loadRequest(request)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func reloadWeb() {
        self.webView?.reload()
    }
    
    func forwardWeb() {
        self.webView?.goForward()
    }
    
    func stopWeb() {
        self.webView?.stopLoading()
    }
    
    func backWeb() {
        self.webView?.goBack()
    }
    
    //
    func updateControlEnabled() {
        stopBtn?.enabled = webView!.loading
        backBtn?.enabled = webView!.canGoBack
        forwardBtn?.enabled = webView!.canGoForward
    }

    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        updateControlEnabled()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        updateControlEnabled()
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        updateControlEnabled()
    }
}

