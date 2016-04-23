//
//  MainTableViewController.swift
//  functionalTableView
//
//  Created by Gatsby on 16/4/19.
//  Copyright © 2016年 Gatsby. All rights reserved.
//

import UIKit

struct T {
    var ok = false
    var qtypes = [Qtype]()
}

class MainTableViewController: UITableViewController, PractiseQtypeBLDelegate{
    
    var rec_data2 = [T]()
    var course: Course!
    var pqBL: PractiseQtypeBL!

    let cellIndenty = "systemCell"
    var mCutsomCell = "mCutsomCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "printName:", name: "sss", object: nil)
        
        self.pqBL = PractiseQtypeBL()
        self.pqBL.delegate = self
        
        course = Course()
        course.c_No = "c00001"

        perpare_data(course)
        
        self.tableView.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColor.grayLightColor237()
        

        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIndenty)
        self.tableView.registerNib(UINib(nibName: "CustsomMainTableViewCell", bundle: nil), forCellReuseIdentifier: mCutsomCell)
        
    }

    func printName(notifaction: NSNotification){
        print( notifaction.object!)
        let c = notifaction.object! as! Course
        course = Course()
        course = c
        //perpare_data(course)
        print(c.c_No, self.course.c_No)
    }
    
    func perpare_data(course:Course){
        self.pqBL.getAllQtypeByCourse(self.course)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //return cellDic.count
        return self.rec_data2.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //    return cellDic[section]!.count
        if self.rec_data2[section].ok {
            return self.rec_data2[section].qtypes.count + 1
        }
        return 1;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let crow = indexPath.row

        if self.rec_data2[section].ok {
            if crow == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier(cellIndenty, forIndexPath: indexPath)
                cell.textLabel!.font = UIFont(name: "MarKer Felt", size: 20)
                cell.textLabel?.text = self.rec_data2[section].qtypes.first!.qtt_NameCn
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier(mCutsomCell, forIndexPath: indexPath) as! CustsomMainTableViewCell
                cell.sectionName.text = rec_data2[section].qtypes[crow - 1].qt_TypeCn
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIndenty, forIndexPath: indexPath)
            cell.textLabel!.font = UIFont(name: "MarKer Felt", size: 20)
            cell.textLabel?.text = self.rec_data2[section].qtypes.first!.qtt_NameCn
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let section = indexPath.section
        let crow = indexPath.row
        
        if crow == 0 {
            var path = [NSIndexPath]()
            for i in 1...(self.rec_data2[section].qtypes.count) {
                path.append(NSIndexPath.init(forItem: crow + i, inSection: section))
            }
            
            if !self.rec_data2[section].ok {
                self.rec_data2[section].ok = !self.rec_data2[section].ok
                self.tableView.beginUpdates()
                self.tableView.insertRowsAtIndexPaths(path, withRowAnimation: UITableViewRowAnimation.Left)
                self.tableView.endUpdates()
            } else {
                self.rec_data2[section].ok = !self.rec_data2[section].ok
                self.tableView.beginUpdates()
                self.tableView.deleteRowsAtIndexPaths(path, withRowAnimation: UITableViewRowAnimation.Left)
                self.tableView.endUpdates()
            }
        }

    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        if indexPath.row == 0 {
            return 70
        }else{
            return 40
        }
    }
    
    func getQtypeByCourseFinished(qtypes: [String: AnyObject]) {
        dispatch_async(dispatch_get_main_queue()) {
            for (_, val) in qtypes {
                var v1 = val as! [Qtype]
                v1.sortInPlace({ (a, b) -> Bool in
                    return a.qt_Aut < b.qt_Aut
                })
                let aItem = T(ok: false, qtypes: v1)
                self.rec_data2.append(aItem)
            }
            self.rec_data2.sortInPlace({ (a, b) -> Bool in
                return a.qtypes.first?.qtt_Aut < b.qtypes.first?.qtt_Aut
            })
            
            self.tableView.reloadData()
        }
    }
    
    func getQtypeByCourseFail(fail: Bool) {
        if fail {
            MBProgressHUD.showDelayHUDToView(self.view, mess: "loading fail", icon: "Icon_err1")
        }
    }
    
    func sendCellInfo(course: Course?) {
        print("ccellleee")
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
