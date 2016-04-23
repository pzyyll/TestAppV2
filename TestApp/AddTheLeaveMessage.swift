//
//  AddTheLeaveMessage.swift
//  Message
//
//  Created by Gatsby on 16/1/25.
//  Copyright © 2016年 Gatsby. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddTheLeaveMessage: UIViewController, UITextViewDelegate {
    
    var textview:UITextView!
    var lplacehold:UILabel!
    var date = NSDate()
    var datestr:String = ""
    
    override func loadView() {
        super.loadView()

        textview = UITextView(frame: CGRectMake(0, 20, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-100))
        textview.backgroundColor = UIColor.whiteColor()
        textview.font = UIFont(name: "Times", size: 20)
        textview.hidden = false
        textview.delegate = self
        textview.bounces = false
        self.view.addSubview(textview)
        
        lplacehold = UILabel(frame: CGRectMake(5,0, 150, 40))
        lplacehold.backgroundColor = UIColor.clearColor()
        lplacehold.text = "有什么想说？"
        lplacehold.enabled = false
        textview.addSubview(lplacehold)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        //let btn = UIBarButtonItem(image: UIImage(named: "exitadd.png"), landscapeImagePhone: nil, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("exitAdd"))
        let btn = UIBarButtonItem(title: "❌", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(AddTheLeaveMessage.exitAdd))
        self.navigationItem.leftBarButtonItem = btn
        let btn2 = UIBarButtonItem(title: "发表", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(AddTheLeaveMessage.doUpload))
        let btn3 = UIBarButtonItem(title: "图片", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        var tn = [UIBarButtonItem]()
        tn.append(btn2)
        tn.append(btn3)
        self.navigationItem.rightBarButtonItems = tn
    }
    
    func hasAllTheBlankSpace() -> Bool{
//        NSString *rawString = [textField text];
//        NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
//        NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
//        if ([trimmed length] == 0) {
//            // Text was empty or only whitespace.
//        }
        let rawString = textview.text
        let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
        let trimmed = rawString.stringByTrimmingCharactersInSet(whitespaceSet)
        if trimmed.isEmpty{
            return true
        }else {
            return false
        }
    }
    
    func addAlert(str:String){
        let alertView = UIAlertController(title: "", message: str, preferredStyle: UIAlertControllerStyle.Alert)
        alertView.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel
            , handler: nil))
        alertView.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (did:UIAlertAction) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
    func exitAdd(){
        addAlert("文字将不会被保存")
    }
    
    func doUpload(){
        //test id = 11 , john.
        
        if !hasAllTheBlankSpace(){
        
        let request = NSMutableURLRequest(URL:NSURL(string: "http://127.0.0.1/ios/exam/putMessages.php")!)
        request.HTTPMethod = "POST"
        //request.setValue(requestToken, forHTTPHeaderField: "Authorization:")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        let dformatter = NSDateFormatter()
        dformatter.dateFormat = "yyy-MM-dd HH:mm:ss"
        self.datestr = dformatter.stringFromDate(self.date)
        
        let values = ["id":"11", "ileave":"\(textview.text)", "lpic":"", "ltime":"\(self.datestr)"]
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(values, options: [])
        
        Alamofire.request(request).responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .Failure( let error):
                    print(error)
                case .Success(let responseObject):
                    print(responseObject)
                }
        }
       self.dismissViewControllerAnimated(true, completion: nil)
        }else{
            addAlert("文字为空无法上传")
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        if (textview.text.isEmpty) {
            lplacehold.text = "有什么想说？"
        }else{
            lplacehold.text = "";
        }
    }
}
