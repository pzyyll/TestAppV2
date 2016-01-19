//
//  SettingView.swift
//  SelfInformation
//
//  Created by Gatsby on 15/12/25.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class SettingView: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var learnStat = ""
    var fromSchool = ""
    var tableView : UITableView!
    
    let Dic = [
        0:["",""],
        1:[""],
    ]
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = "设置"
        tableviewPrepare()
    }
    
    func tableviewPrepare(){
        let item = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)//导航栏返回的按键名
        self.navigationItem.backBarButtonItem = item;
        
        self.tableView = UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height),
            style: UITableViewStyle.Grouped)//创建表视图
        self.tableView.dataSource=self//数据源
        self.tableView.delegate=self//委托
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "aCell")
        
        self.view.addSubview(self.tableView)

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.Dic.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.Dic[section]!.count
    }
    
    //MARK:单元格表头高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 1//表头高度
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {//选中单元格
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let secno = indexPath.section
        if secno == 0{//在第一个分区
            if indexPath.row == 0{//选中第一行
                print("row 1")//MARK:待添加选中学习状态功能
            }
            else {
                print("row 2")//MARK:待添加选中学校功能
            }
        }
        else {
            //print("row 3")//MARK:关于开发
            let aboutPage = AboutPageView()
            self.navigationController?.pushViewController(aboutPage, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell{
        
        let secno = indexPath.section
        if secno == 0{//分区1
            if indexPath.row == 0{//第一行
                let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "learnStat")
                cell.textLabel?.text = "学习阶段"
                cell.detailTextLabel?.text = self.learnStat//数据来自json
                
                return cell
            }
            else{//第二行
                let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "fromSchool")
                cell.textLabel?.text = "学校"
                cell.detailTextLabel?.text = self.fromSchool//数据来自json
                
                return cell
            }
        }//end secno == 0
        else {//分区2
            let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "about")
            cell.textLabel?.text = "关于开发"
            cell.detailTextLabel?.text = "版本v1.0"
            return cell
        }
    }

}