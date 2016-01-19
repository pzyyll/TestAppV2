//
//  ViewController.swift
//  UITableView
//
//  Created by chuna on 15/12/4.
//  Copyright (c) 2015年 chuna. All rights reserved.
//

import UIKit

var index = 0
var allNotes = [String]()

class MyTableView2: UIViewController,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UISearchBarDelegate {

    var tableView:UITableView!             //定义表示图对象
    private let identify:String = "aCell"  //单元格名字
    
    var searchBar = UISearchBar()  //创建UISearchBar对象

    var adHeaders = ctrlsel[currentSection].c_Name[currentCourseNum].c_Name

    var allnames = [String]()  //所有控件字典
    var backButton = UIButton()
    var vie = UIView()
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
 
        allNotes = []
        allNotes = ctrlsel[currentSection].c_Name[currentCourseNum].c_Information
//        导航标题
        self.title = ctrlsel[currentSection].c_Name[currentCourseNum].c_Name

        self.allnames = allNotes
//        self.ctrlsel = self.allnames  // 起始
        
        //1.使用frame和风格初始化一个表视图对象
        self.tableView = UITableView(frame: self.view.frame,
                                    style: UITableViewStyle.Grouped)
        

        //2.设置数据源和委托，并使加载了表视图的类继承两个协议，实现协议中规定的方法
        self.tableView.dataSource=self
        self.tableView.delegate=self
        //3.创建一个重用的单元格，注册
        self.tableView.registerClass(UITableViewCell.self ,
                                     forCellReuseIdentifier: identify)
        //4.
        self.view.addSubview(self.tableView)
        
        //5.绑定对长按手势的响应
        let longPress =  UILongPressGestureRecognizer(target:self,
            action:Selector("tableviewCellLongPressed:"))
//        longPress.delegate = self  //代理
        longPress.minimumPressDuration = 1.0
        //将长按手势添加到需要实现长按操作的视图里
        self.tableView.addGestureRecognizer(longPress)
        
        //6.
//        var searchBar = UISearchBar()  //创建UISearchBar对象
        searchBar.sizeToFit()          //
        searchBar.showsCancelButton = true //显示取消按钮
        searchBar.delegate=self                //设置搜索条的委托
        self.tableView.tableHeaderView = searchBar //为表添加搜索条

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:长按方法
    func tableviewCellLongPressed(gestureRecognizer:UILongPressGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            if self.tableView!.editing == false {
                self.tableView!.setEditing(true, animated: true)
            }
            else{
                self.tableView!.setEditing(false, animated: true)
            }
        }
    }
    
    //MARK:UITableViewDataSource协议中的方法
    
    //返回分区数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return self.allnames.count
        return 1
    }
    
    //1.返回每个分区的行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.ctrls.count
        //return self.allnames[section]!.count
        return allNotes.count
    }
    
    //2.设置单元格显示内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //单元格重用
        var data = allNotes[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identify,
                forIndexPath: indexPath) as! UITableViewCell
            
            cell.textLabel!.text = data
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell

    }
    
    
    //4.配置分区尾部标题,可选实现
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        //let data = self.allnames[section]!
        let data = allNotes
        return "有\(data.count)套试卷"
    }
    
    //MARK:UITableViewDelegate协议中的方法
    //处理选中单元格事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //取消选中状态
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //获取被选中的单元格内容
        //let itemStr = self.ctrls[indexPath.row]
        //let itemStr = self.allnames[indexPath.section]![indexPath.row]
        let itemStr = allNotes[indexPath.row]
        
        let alertview = UIAlertView()
        alertview.title = "提示"
        alertview.message="你选中了【\(itemStr)】"
        alertview.addButtonWithTitle("OK")
        alertview.show()
        
        //界面跳转
//        var detail = MyDetailViewController()
//        detail.title = itemStr["name"]
//        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    //2.设置编辑状态
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if indexPath.section == 1 {
            return UITableViewCellEditingStyle.Insert
        }
        return UITableViewCellEditingStyle.Delete
    }
    
    //4.提交编辑，生效
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {

            allNotes.removeAtIndex(indexPath.row)
       
            self.tableView.reloadData()//更新表
        }
        else if editingStyle == UITableViewCellEditingStyle.Insert {

        }
    }

   // MARK: 搜索代理UISearchBarDelegate方法，每次改变搜索内容时都会调用
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {    // 没有搜索内容时显示全部组件
                allNotes = self.allnames
        }
        else {                    // 匹配用户输入内容的前缀
            allNotes = []
            //只要元素中带有字符串便查找
            for ctrl in self.allnames {
                    if ctrl.hasPrefix(searchText){
                        if allNotes != [] {
                            allNotes.append(ctrl)
                        }
                        else{
                            allNotes.append(ctrl)
                        }
                }
                
            }
        }
        
        self.tableView.reloadData()// 刷新Table View显示
    }
    
    // 搜索代理UISearchBarDelegate方法，点击虚拟键盘上的Search按钮时触发
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }

}

