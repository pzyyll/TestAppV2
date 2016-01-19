//
//  MyDetailViewController.swift
//  UITableView
//
//  Created by 褚娜 on 15/12/1.
//  Copyright (c) 2015年 chuna. All rights reserved.
//

import UIKit

class MyDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //视图的背景色
        self.view.backgroundColor = UIColor.whiteColor()
        //按title加载控件
        loadControl(self.title!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadControl(ctrl:String){
        let label = UILabel()
        label.frame = CGRectMake(self.view.bounds.size.width * 1/10, self.view.bounds.size.height * 1/10, self.view.bounds.size.width , self.view.bounds.size.height * 1/10)
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(16)
        label.text = "内容:"
        self.view.addSubview(label)
        let jsonFilePath = "/Users/caizhili/Desktop/test.json"
        
        //        let jsonFilePath = NSBundle.mainBundle().pathForResource("test", ofType: "json")
        let data = NSData(contentsOfFile: jsonFilePath)
        let jsonObj = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
        var showContent = String()
        var showTime = String()
        
        for person in jsonObj! {
            if person["name"] as! String == self.title {
                showContent = person["content"] as! String
                showTime = person["time"] as! String
            }
        }
        
        let label1 = UILabel()
        label1.frame = CGRectMake(self.view.bounds.size.width * 1/10, self.view.bounds.size.height * 2/10, self.view.bounds.size.width , self.view.bounds.size.height * 5/10)
        label1.backgroundColor = UIColor.clearColor()
        label1.textAlignment = NSTextAlignment.Center
        label1.font = UIFont.systemFontOfSize(16)
        label1.text = showContent
        self.view.addSubview(label1)
        
        let label2 = UILabel()
        label2.frame = CGRectMake(self.view.bounds.size.width * 1/10, self.view.bounds.size.height * 7/10, self.view.bounds.size.width , self.view.bounds.size.height * 1/10)
        label2.backgroundColor = UIColor.clearColor()
        label2.textAlignment = NSTextAlignment.Center
        label2.font = UIFont.systemFontOfSize(16)
        label2.text = "留言时间:"
        self.view.addSubview(label2)
        
        let label3 = UILabel()
        label3.frame = CGRectMake(self.view.bounds.size.width * 1/10, self.view.bounds.size.height * 8/10, self.view.bounds.size.width * 8/10, self.view.bounds.size.height * 2/10)
        label3.backgroundColor = UIColor.clearColor()
        label3.textAlignment = NSTextAlignment.Center
        label3.font = UIFont.systemFontOfSize(16)
        label3.text = showTime
        self.view.addSubview(label3)
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
