//
//  MyTableView.swift
//  TestApp
//
//  Created by CAIZHILI on 15/12/28.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import UIKit

protocol MyTableViewContrlerDelegate {
    func showAler(view: UIViewController)
}

class MyTableView: UITableView, UITableViewDataSource,
UITableViewDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    let optionImgs = ["A_32px", "B_32px", "C_32px", "D_32px"]
    
    var dataOption: OptionItem?
    
    var titleView: UIView!
    var titleLeftItem: UILabel!
    var titleRightItem: UILabel!
    let identify = "aCell"
    
    //代理方法
    var contrlDelegate: MyTableViewContrlerDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: .Plain)
        
        self.titleView = UIView(frame: CGRectMake(0, 0, self.frame.width, 30))
        self.titleView.backgroundColor = UIColor(red: 253/255, green: 252/255, blue: 249/255, alpha: 1)
        
        let separatorLine: CGFloat = 60.0
        self.titleLeftItem = UILabel(frame: CGRectMake(0, 0, self.titleView.frame.width - separatorLine, 30))
        self.titleRightItem = UILabel(frame: CGRectMake(self.titleView.frame.width - separatorLine, 0, separatorLine, 30))
        self.titleRightItem.textAlignment = .Center
        
        self.titleView.addSubview(self.titleLeftItem)
        self.titleView.addSubview(self.titleRightItem)
        self.tableHeaderView = self.titleView
        
        self.separatorStyle = .None
        
        //设置tableview 相关协议
        self.dataSource = self
        self.delegate = self
        self.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.identify)
        
        self.dataOption = OptionItem()
    }

    func setTitleLeftItemText(title: String) {
        self.titleLeftItem.text = title
        self.titleLeftItem.font = UIFont.systemFontOfSize(15)
    }
    
    func setTitleRightItemText(leftNum: Int, rightNum: Int) {
        let needAddStr = "\(leftNum)/\(rightNum)"
        let formStr = NSMutableAttributedString(string: needAddStr, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(12)])
        let transLen = String(leftNum).characters.count
        formStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(25), range: NSMakeRange(0, transLen))
        formStr.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 129/255, green: 1, blue: 56/255, alpha: 1), range: NSMakeRange(0, transLen))
        
        self.titleRightItem.attributedText = formStr
        
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.dataOption!.title != "") {
            return self.dataOption!.options!.count + 1
        }
        return self.dataOption!.options!.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: self.identify)
        let font = UIFont.systemFontOfSize(12)
        //var displayStr = NSString()
        
        if (self.dataOption!.title != "" && indexPath.row == 0) {
            cell.textLabel?.text = self.dataOption!.title
            cell.selectionStyle = .None
        } else if (self.dataOption!.title != "") {
            cell.textLabel?.text = self.dataOption!.options![indexPath.row - 1]
            let img = UIImage(named: self.optionImgs[indexPath.row - 1])
            cell.imageView?.image = UIImage(data: UIImagePNGRepresentation(img!)!, scale: 3.0)
            cell.imageView?.tintColor = UIColor.blueColor()
        } else {
            cell.textLabel?.text = self.dataOption!.options![indexPath.row]
            let img = UIImage(named: self.optionImgs[indexPath.row])
            cell.imageView?.image = UIImage(data: UIImagePNGRepresentation(img!)!, scale: 3.0)
        }
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = font
        cell.textLabel?.lineBreakMode = .ByWordWrapping
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let row = indexPath.row
        let contentWidth = self.frame.width
        let font = UIFont.systemFontOfSize(12)
        var content: NSString!
        
        if (row == 0 && self.dataOption!.title != "") {
            content = NSString(string: self.dataOption!.title)
        } else if (self.dataOption!.title != "") {
            content = NSString(string: self.dataOption!.options![row - 1])
        } else {
            content = NSString(string: self.dataOption!.options![row])
        }
        
        let size = content.boundingRectWithSize(CGSizeMake(contentWidth, 500), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return size.height + 20
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alerView = UIAlertController(title: "yes", message: "sorry~~功能还没完成>_<", preferredStyle: UIAlertControllerStyle.Alert)
        alerView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.contrlDelegate?.showAler(alerView)
    }

}
