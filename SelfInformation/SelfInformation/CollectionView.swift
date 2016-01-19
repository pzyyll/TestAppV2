//
//  CollectionView.swift
//  SelfInformation
//
//  Created by Gatsby on 15/12/25.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class CollectionView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView : UITableView!
    
    override func viewDidLoad() {
         self.view.backgroundColor = UIColor.whiteColor()
         self.title = "习题收藏"
    
         tableviewPrepare()
    }

    func tableviewPrepare(){
        self.tableView = UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height),
            style: UITableViewStyle.Grouped)//创建表视图
        self.tableView.dataSource=self//数据源
        self.tableView.delegate=self//委托
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "aCell")
        
        self.view.addSubview(self.tableView)

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {//分区数
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{//区内行数
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 1//表头高度
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 0{
        //cet4
        }
        else if indexPath.row == 1{
        //cet6
        }
        else{
        //cet8
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if indexPath.row == 0{
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "testOthers")
            cell.textLabel?.text = "英语"
        
            return cell
        }
        else if indexPath.row == 1{
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "testOthers")
            cell.textLabel?.text = ""
            return cell
        }
        else {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "testOthers")
            cell.textLabel?.text = ""
            
            return cell
        }
    }
    
}
