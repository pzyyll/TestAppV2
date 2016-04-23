//
//  MsgCutsomTableViewCell.swift
//  TestApp
//
//  Created by Gatsby on 16/4/23.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class MsgCutsomTableViewCell: UITableViewCell {

    var imageInCell:UIView!
    var btname:UIButton!
    var ltime:UILabel!
    var lmessage:UILabel!
    
    /////////////////////////
    var rect:CGRect!
    var u_mesg:String!//content of message of users
    var u_time:String!
    var u_name:String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    init(reuseIdentifier cellId:String, item:MessageItem) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier:cellId)
        self.u_mesg = item.mesg
        self.u_name = item.username
        self.rect = item.count_mesg_height(.NORMALCELL).full_mesg_rect
        self.u_time = item.time
        rebuildCellInterface(item)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func rebuildCellInterface(item:MessageItem){
        self.selectionStyle = UITableViewCellSelectionStyle.Blue//cell被选中的风格设置
        
        imageInCell = UIImageView(image:UIImage(named: "userIcon"))//json
        imageInCell.layer.cornerRadius = imageInCell.frame.width/3//改变圆角半径
        imageInCell.layer.borderWidth = 3.0//边界宽度
        imageInCell.layer.borderColor = UIColor.grayColor().CGColor//宽设灰色
        imageInCell.clipsToBounds = true//剪掉边缘部分
        imageInCell.frame = CGRectMake(20,20,50,50)
        
        btname = UIButton()
        btname.setTitle(u_name, forState: UIControlState.Normal)
        btname.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btname.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        //btname.backgroundColor = UIColor.greenColor()
        btname.titleLabel!.font = UIFont(name: "", size: 10)
        btname.contentHorizontalAlignment = .Left
        btname.frame = CGRectMake(100, 20, 50, 20)
        
        ltime = UILabel()
        ltime.text = u_time//来自json
        ltime.textColor = UIColor.grayColor()
        ltime.textAlignment = NSTextAlignment.Left
        //ltime.backgroundColor = UIColor.brownColor()
        ltime.frame = CGRectMake(190, 20, 170, 20)
        
        lmessage = UILabel()
        lmessage.text = u_mesg
        lmessage.numberOfLines = 0
        //lmessage.font = UIFont(name: "", size: 10)
        lmessage.frame = rect
        //lmessage.backgroundColor = UIColor.yellowColor()
        
        let mReply = UIImageView(image: UIImage(named: "mReply.png"))
        //mReply.backgroundColor = UIColor.greenColor()
        mReply.frame = CGRectMake(UIScreen.mainScreen().bounds.width - 80, item.count_mesg_height(.NORMALCELL).mesg_high+70,10,10)
        
        let cReply = UILabel()
        cReply.frame = CGRectMake(UIScreen.mainScreen().bounds.width - 65, item.count_mesg_height(.NORMALCELL).mesg_high+70, 20, 10)
        
        cReply.text = "0"
        cReply.font = UIFont(name: "Times", size: 10)
        
        self.addSubview(imageInCell)
        self.addSubview(btname)
        self.addSubview(ltime)
        self.addSubview(lmessage)
        self.addSubview(mReply)
        self.addSubview(cReply)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
