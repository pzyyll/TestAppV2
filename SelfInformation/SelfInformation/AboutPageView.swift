//
//  AboutPageView.swift
//  SelfInformation
//
//  Created by Gatsby on 15/12/25.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class AboutPageView: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    var tableView : UITableView!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "关于开发"
        
        loadPicture()
        tableviewPrepare()
    }
    
    func loadPicture(){
        let newImage = UIImage(named: "logo.png")
        let imageView = UIImageView(image:newImage);
        imageView.frame=CGRectMake(30,100,350,150)
        self.view.addSubview(imageView)
    }
    
    func tableviewPrepare(){
        self.tableView = UITableView(frame: CGRectMake(0, 300, self.view.bounds.width, self.view.bounds.height),
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
        return 4
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 10//表头高度
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {//选中单元格
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 0{//选中第一行
                //MARK:添加更新功能
        }
        else if indexPath.row == 1{
               //MARK:跳转至教程页面
        }
        else if indexPath.row == 2{
                //MARK:跳转至留言页面
        }
        else{
            //MARK: 添加联系功能
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if indexPath.row == 0{
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "test1")
            cell.textLabel?.text = "检查版本更新"
            cell.detailTextLabel?.text = "v1.0"
        return cell
        }
        else if indexPath.row == 1{
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "testOthers")
            cell.textLabel?.text = "软件使用教程"
            //cell.detailTextLabel?.text = "StandingBy"
            return cell
        }
        else if indexPath.row == 2{
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "testOthers")
            cell.textLabel?.text = "意见反馈"
            
            return cell
        }
        else{
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "feedback")
            cell.textLabel?.text = "联系我们"
            
            return cell
        }
    }
    
}
