//
//  TheDetailMesgTableViewController.swift
//  Message
//
//  Created by Gatsby on 16/1/22.
//  Copyright © 2016年 Gatsby. All rights reserved.
//

import UIKit

class TheDetailMesgTableViewController: UITableViewController {
   
    var insideMesg:MessageItem!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brownColor()
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "test2")
        self.tableView.bounces = false
        //self.tableView.dataSource = MessageTableViewController()//数据源来自MessageTableViewController
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     override func tableView(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat{
        return 10
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        if indexPath.section == 0{
            return insideMesg.count_mesg_height(.DETAILCELL).mesg_high + 100 + 40
        }
        else{
            return 100
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//需要两个分区,剩一个给回复
    }
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = MyDetailTableViewCell(reuseIdentifier: "test2", item: insideMesg)
            cell.selectionStyle = UITableViewCellSelectionStyle.None;
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("test2", forIndexPath: indexPath)
        return cell
    }
}
