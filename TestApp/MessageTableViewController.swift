//
//  MessageTableViewController.swift
//  Message
//
//  Created by Gatsby on 15/12/29.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MessageTableViewController: UITableViewController {

    var messageitem:[MessageItem] = []
    var refreshcontrol = UIRefreshControl()
    var timer: NSTimer!
    var aler: UILabel!
    var lastPostion : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIBarButtonItem(image: UIImage(named: "addMesg.png"), landscapeImagePhone: nil, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MessageTableViewController.addMesg))
        self.navigationItem.rightBarButtonItem = btn
        navigationPrepare()
        ///////////////////////////////
        //刷新控制器
        self.automaticallyAdjustsScrollViewInsets = true
        refreshcontrol.backgroundColor = UIColor.clearColor()
        refreshcontrol.tintColor = UIColor.blueColor()
        refreshcontrol.addTarget(self, action: #selector(MessageTableViewController.refreshData),forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(refreshcontrol)
        
        //////////////////////////////
        thejsonAct()
        
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "test")
        //self.tableView.bounces = false
    }
    
    func addMesg(){
        let nav = UINavigationController(rootViewController: AddTheLeaveMessage())
        nav.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        self.presentViewController(nav, animated: true, completion: nil)
        //self.navigationController?.pushViewController(addMesgView,animated: true)
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //print("beginDrag")
        if !refreshcontrol.refreshing {
            
        }
    }

    func refreshData() {
        print("refresh")
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self,
            selector: #selector(MessageTableViewController.dataRefresh), userInfo: nil, repeats: true)//给点时间操作，不然会crash掉
        }
    
    func dataRefresh(){
        self.messageitem.removeAll()//MARK:更新暂时重清所有
        thejsonAct()
        self.refreshcontrol.endRefreshing()

        timer.invalidate()
        timer = nil
    }
    
    func navigationPrepare(){
        self.title = "留言版"
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor =
            UIColor(red: 0/255, green: 160/255, blue: 255/255, alpha: 1)//导航栏背景颜色
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]//文字颜色
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()//按钮颜色
        let item = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)//导航栏返回的按键名
        self.navigationItem.backBarButtonItem = item;
        
        //print("navigation loaded")
    }
    
    func thejsonAct(){
        Alamofire.request(.POST, "http://127.0.0.1/ios/exam/getMessages.php", parameters: ["":""]).authenticate(user: "ooly.club", password: "ooly.club116000+q").response{
            (request, response, data, error) -> Void in
        
            if error != nil{
                print(error)
            }else{
                let json = JSON(data: data!)
                print(json)
                for i in 0 ..< json.count{
                    let pep = MessageItem()
                    pep.mesg = json[i]["message"].string
                    pep.username = json[i]["username"].string
                    pep.time = json[i]["add_time"].string
                    pep.imageOfMesg = json[i]["user_img"].string
                    self.messageitem.append(pep)
                    }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in//异步
                    self.messageitem.sortInPlace(self.sortDate)
                    self.tableView.reloadData()
                })
                
                }
            }
        }
    
    func sortDate(m1: MessageItem!, m2: MessageItem!) -> Bool{
        let formDate = NSDateFormatter()
        formDate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let m1Date = formDate.dateFromString(m1.time)
        let m2Date = formDate.dateFromString(m2.time)
        if m1Date!.timeIntervalSince1970 > m2Date!.timeIntervalSince1970 {
                return true
        } else {
            return false
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageitem.count
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        let the_high = messageitem[indexPath.row].count_mesg_height(.NORMALCELL)
        return the_high.mesg_high + 50 + 50//设置自动行高
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let testDetail = TheDetailMesgTableViewController()
        testDetail.insideMesg = self.messageitem[indexPath.row]//以后使用数据源优化?
        self.navigationController?.pushViewController(testDetail,animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                let cell_Data = self.messageitem[indexPath.row]
                let cell = MsgCutsomTableViewCell(reuseIdentifier:"test", item:cell_Data)
                return cell
    }

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let height = self.view.frame.size.height
        let distanceFromButton = self.tableView.contentSize.height - self.tableView.contentOffset.y
               
        let offset = self.tableView.contentOffset.y
        
        if offset - lastPostion > 10 {
            //print("视图向上滚动 contentOffset.y - lastPostion = \(offset - lastPostion) , contentOffset.y = \(offset),lastPostion = \(lastPostion)")
            lastPostion = offset
        }else if lastPostion - offset > 10 {
            
            //print("视图向下滚动 lastPostion - contentOffset.y = \(lastPostion - offset) , contentOffset.y = \(offset),lastPostion = \(lastPostion), height = \(height)")
            lastPostion = offset
        }
        
        if( Int(distanceFromButton) == Int(height) ){
                //print("底了")
                showLiGeSmallAlert()
            }
    }

    func showLiGeSmallAlert(){
        self.aler = UILabel(frame: CGRectMake(0, 0, 80, 20))
        self.aler.center = CGPointMake(self.view.frame.width / 2, self.tableView.contentSize.height-100)
        self.aler.backgroundColor = UIColor(red: 26 / 255, green: 26 / 255, blue: 26 / 255, alpha: 0.8)
        self.aler.text = "最底了～"
        self.aler.textAlignment = .Center
        self.aler.font = UIFont.systemFontOfSize(20)
        self.aler.textColor = UIColor.whiteColor()
        self.aler.layer.cornerRadius = 2
        self.aler.layer.masksToBounds = true
        
        //print(self.aler.center)
        
        self.view.addSubview(self.aler)
        
        UIView.animateWithDuration(4, animations: { () -> Void in
            self.aler.alpha = 0.0
            }) { (finished) -> Void in
                self.aler.removeFromSuperview()
        }

    }
    
        /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
