//
//  ViewController.swift
//  NavigationTalking
//
//  Created by dragon on 15/12/15.
//  Copyright © 2015年 dragon. All rights reserved.
//

import UIKit

class ViewControllerRy: UIViewController{
    
    var tableView = UITableView()
    var navigationView = UINavigationBar()
    var backButton = UIButton()
    var NewButton = UIButton()
    var textView = UITextView()
    var textViewName = UITextView()
    var textViewLable = UILabel()
    var textViewContent = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nextItem=UIBarButtonItem(title:"完成",style:.Plain,target:self,action:"actionOk:");
        //  添加到到导航栏上
        self.navigationItem.rightBarButtonItem = nextItem;
        
        textViewLable.frame = CGRectMake(0, 50, self.view.frame.width, 50)
        textViewLable.backgroundColor = UIColor.whiteColor()
        textViewLable.textColor = UIColor.redColor()
        textViewLable.text = "name:"
        
        textViewName.frame = CGRectMake(0, 100, self.view.frame.width, 50)
        textViewName.backgroundColor = UIColor.grayColor()
        textViewName.textColor = UIColor.redColor()
        
        textViewContent.frame = CGRectMake(0, 150, self.view.frame.width, 50)
        textViewContent.backgroundColor = UIColor.whiteColor()
        textViewContent.textColor = UIColor.redColor()
        textViewContent.text = "content:"
        
        textView.frame = CGRectMake(0, 200, self.view.frame.width, self.view.frame.height - 200)
        textView.backgroundColor = UIColor.grayColor()
        textView.textColor = UIColor.redColor()
        
        self.view.addSubview(textViewLable)
        self.view.addSubview(textViewName)
        self.view.addSubview(textViewContent)
        
        self.view.addSubview(navigationView)
        self.view.addSubview(textView)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func actionOk(sender:AnyObject?) {
        //        let viewCon = MyTableView()
        
        //        if textView.text != nil && textViewName.text != nil {
        let row = allNotes2.count
        let indexPath = NSIndexPath(forRow:row,inSection:0)
        
        let date = NSDate()
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "yyy-MM-dd 'at' HH:mm:ss.SSS"
        let strNowTime = timeFormatter.stringFromDate(date) as String
        
        //            allNotes.insert([ "content": textView.text, "time": strNowTime,"id": "004", "name": textViewName.text], atIndex: 0)
        allNotes2.append([ "content": textView.text, "time": strNowTime,"id": "004", "name": textViewName.text])
        let jsonDict = try? NSJSONSerialization.dataWithJSONObject(allNotes2, options: NSJSONWritingOptions())
        //            print(jsonDict)
        //直接写入文件
        let jsonFilePath = "/Users/raoyu/Desktop/test.json"
        
        jsonDict?.writeToFile(jsonFilePath, atomically: true)
        //        也可以把Json转换为String字符串
        let str = NSString(data: jsonDict!, encoding: NSUTF8StringEncoding)
        print(str)
        //            allNotes.append(textView.text)
        
        print(textView.text)
        //            viewCon.tableView?.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        //        }
        self.navigationController?.popViewControllerAnimated(false)
        
    }
    
    
    
    
}

