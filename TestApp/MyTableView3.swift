//
//  ViewController.swift
//  UITableView
//
//  Created by chuna on 15/12/4.
//  Copyright (c) 2015年 chuna. All rights reserved.
//

import UIKit

var index2 = 0
var allNotes2 = [Dictionary<String,String>]()

class MyTableView3: UIViewController,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UISearchBarDelegate {
    
    var tableView:UITableView!             //定义表示图对象
    private let identify:String = "aCell"  //单元格名字
    
    //    var allNotes = [Dictionary<String,String>]()
    var searchBar = UISearchBar()  //创建UISearchBar对象
    
    var adHeaders = "用户留言"
    
    var allnames = [Dictionary<String,String>]()  //所有控件字典
    //    var ctrlsel = [Dictionary<String,String>]()  // 搜索匹配的结果，Table View使用这个数组作为datasource
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        allNotes2 = []
        //        导航标题
        self.title = "用户留言"
        let jsonFilePath = "/Users/caizhili/Desktop/test.json"
        //        let jsonFilePath = NSBundle.mainBundle().pathForResource("test", ofType: "json")!
        let data = NSData(contentsOfFile: jsonFilePath)
        let jsonObj = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as!    NSMutableArray
        for person in jsonObj! {
            //            let id = person["id"] as! String
            //            print(id)
            //            let name = person["name"] as! String
            //            print(name)
            //            let content = person["content"] as! String
            //            print(content)
            //            let time = person["time"] as! String
            //            print(time)
            allNotes2.append(person as! Dictionary<String, String>)
        }
        self.allnames = allNotes2
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
        
        let item1=UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target:self, action: "add")//此处使用的图标UIBarButtonSystemItem是一个枚举.大家可以尝试一下其他值出来是什么
        self.navigationItem.rightBarButtonItem=item1
    }
    func add() {
        index2 = 0
        let controller = ViewControllerRy()
        //        self.presentViewController(controller, animated: true, completion: nil)
        self.navigationController?.pushViewController(controller, animated: false)
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
        return allNotes2.count
    }
    
    //2.设置单元格显示内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //单元格重用
        //let cell = tableView.dequeueReusableCellWithIdentifier(identify,
        //forIndexPath: indexPath) as! UITableViewCell
        //配置单元格
        //cell.textLabel!.text = self.ctrls[indexPath.row] //主标题
        //cell.imageView!.image=   //图片
        //cell.detailTextLabel!.text= //在default风格下，没有副标题
        
        //var data = self.allnames[secno]!
        var data = allNotes2[indexPath.row]["name"]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identify,
            forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = data
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
        
    }
    
    //3.配置分区头部标题，可选实现
    //    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return adHeaders
    //    }
    
    //4.配置分区尾部标题,可选实现
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        //let data = self.allnames[section]!
        let data = allNotes2
        return "有\(data.count)个留言"
    }
    
    //MARK:UITableViewDelegate协议中的方法
    //处理选中单元格事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //取消选中状态
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //获取被选中的单元格内容
        //let itemStr = self.ctrls[indexPath.row]
        //let itemStr = self.allnames[indexPath.section]![indexPath.row]
        let itemStr = allNotes2[indexPath.row]
        
        //界面跳转
        var detail = MyDetailViewController()
        detail.title = itemStr["name"]
        self.navigationController?.pushViewController(detail, animated: true)
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
            //            let jsonFilePath = NSBundle.mainBundle().pathForResource("test", ofType: "json")!
            let jsonFilePath = "/Users/raoyu/Desktop/test.json"
            allNotes2.removeAtIndex(indexPath.row)
            
            let jsonDict = try? NSJSONSerialization.dataWithJSONObject(allNotes2, options: NSJSONWritingOptions())
            
            //直接写入文件
            
            jsonDict?.writeToFile(jsonFilePath, atomically: true)
            
            let str = NSString(data: jsonDict!, encoding: NSUTF8StringEncoding)
            print(str)
            
            self.tableView.reloadData()//更新表
            //            self.tableView!.setEditing(true, animated: true)   //不用，默认就还是编辑状态
        }
        else if editingStyle == UITableViewCellEditingStyle.Insert {
            allNotes2.insert(["content":"哈哈哈哈","id":"004","time":"2015-12-16 at 03:13:13.933","name":"你好"], atIndex: indexPath.row)
            let jsonDict = try? NSJSONSerialization.dataWithJSONObject(allNotes2, options: NSJSONWritingOptions())
            print(jsonDict)
            //直接写入文件
            let jsonFilePath = "/Users/raoyu/Desktop/test.json"
            //            let jsonFilePath = NSBundle.mainBundle().pathForResource("test", ofType: "json")!
            jsonDict?.writeToFile(jsonFilePath, atomically: true)
            let str = NSString(data: jsonDict!, encoding: NSUTF8StringEncoding)
            print(str)
            self.tableView.reloadData()
        }
    }
    
    //MARK: 搜索代理UISearchBarDelegate方法，每次改变搜索内容时都会调用
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {    // 没有搜索内容时显示全部组件
            allNotes2 = self.allnames
        }
        else {                    // 匹配用户输入内容的前缀
            allNotes2 = []
            //只要元素中带有字符串便查找
            for ctrl in self.allnames {
                for ct in ctrl.values {
                    if ct.hasPrefix(searchText){
                        if allNotes2 != [] {
                            allNotes2.append(ctrl)
                        }
                        else{
                            allNotes2.append(ctrl)
                        }
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

