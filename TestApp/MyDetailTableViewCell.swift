//
//  MyDetailTableViewCell.swift
//  Message
//
//  Created by Gatsby on 16/1/21.
//  Copyright © 2016年 Gatsby. All rights reserved.
//

import UIKit

class MyDetailTableViewCell : UITableViewCell, ContextLabelDelegate{
    var imageInCell:UIButton!
    var btname:UIButton!
    var ltime:UILabel!
    var lmessage:ContextLabel!
    
    var rect:CGRect!
    var u_mesg:String!//content of message of users
    var u_time:String!
    var u_name:String!
    
    init(reuseIdentifier cellId:String, item:MessageItem) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier:cellId)
        u_name = item.username
        u_mesg = item.mesg
        u_time = item.time
        rect = item.count_mesg_height(.DETAILCELL).full_mesg_rect
        rebuildCellInterface(item)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func rebuildCellInterface(item:MessageItem){
        imageInCell = UIButton(frame: CGRectMake(20, 20, 70, 70))
        imageInCell.setBackgroundImage(UIImage(named:"userIcon"), forState: UIControlState.Normal)
        //imageInCell.backgroundColor = UIColor.greenColor()
        
        btname = UIButton(frame: CGRectMake(100, 25, 70, 30))
        btname.setTitle(u_name, forState: UIControlState.Normal)
        btname.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btname.contentHorizontalAlignment = .Left
        //btname.backgroundColor = UIColor.greenColor()
        
        lmessage = ContextLabel()
        lmessage.text = u_mesg
        lmessage.numberOfLines = 0
        lmessage.font = UIFont(name: "", size: 10)
        //lmessage.backgroundColor = UIColor.grayColor()
        lmessage.frame = rect
        lmessage.delegate = self
        
        ltime = UILabel()
        ltime.text = u_time
        ltime.textColor = UIColor.grayColor()
        ltime.frame = CGRectMake(20, 100 + item.count_mesg_height(.DETAILCELL).mesg_high + 10, 200, 20)
        //ltime.backgroundColor = UIColor.redColor()
        self.addSubview(imageInCell)
        self.addSubview(btname)
        self.addSubview(lmessage)
        self.addSubview(ltime)
    }
    
    func contextLabel(contextLabel: ContextLabel, beganTouchOf text: String, with linkRangeResult: LinkRangeResult){
        print("touch begin \(text)")
       // self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
       let cleanURL = NSURL(string: text)
       UIApplication.sharedApplication().openURL(cleanURL!)
    }
    
    func contextLabel(contextLabel: ContextLabel, movedTouchTo text: String, with linkRangeResult: LinkRangeResult){
        print("touch move")
    }
    
    func contextLabel(contextLabel: ContextLabel, endedTouchOf text: String, with linkRangeResult: LinkRangeResult){
        print("touch end")
    }
}
