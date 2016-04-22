//
//  MainTableViewController.swift
//  functionalTableView
//
//  Created by Gatsby on 16/4/19.
//  Copyright © 2016年 Gatsby. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    var dic:Dictionary<String,String> = ["cell":"systemCell", "isAttached":"false"]
    
    var rec_data = [0:["LISTENNING COMPREHENSION", "SHORT CONVERSATIONS", "LONG CONVERSATIONS", "SHORT PASSAGES", "NEWS"],
                       1:["READING COMPREHENSION", "READING SECTION A", "READING SECTION B", "READING SECTION C"],
                       2:["TRANSLATION", "TRanslation"]]
    
    var cellDic : [Int:[Dictionary<String, String>]] = [:]
    var countRowArr : [Int] = []
    
    var testBool = false
    let cellIndenty = "systemCell"
    var mCutsomCell = "mCutsomCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIndenty)
        self.tableView.registerNib(UINib(nibName: "CustsomMainTableViewCell", bundle: nil), forCellReuseIdentifier: mCutsomCell)
        perpare_data()
    }

    func perpare_data(){
        
        for i in 0..<rec_data.count{
            var countThing = 0
            cellDic.updateValue([dic], forKey: i)//[0:[dic,dic],1:[dic],2:[dic]]
            for _ in 1..<rec_data[i]!.count{
                countThing += 1
            }
            countRowArr.append(countThing)
        }
        //print(cellDic[0]![0]["cell"])
        print("countRowArr :\(countRowArr)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return cellDic.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
            return cellDic[section]!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let crow = indexPath.row
        
                if cellDic[section]![crow]["cell"] == cellIndenty{
                    let cell = tableView.dequeueReusableCellWithIdentifier(cellIndenty, forIndexPath: indexPath)
                    cell.textLabel!.font = UIFont(name: "MarKer Felt", size: 25)
                    cell.textLabel?.text = rec_data[section]![crow]
                      return cell
                }else if cellDic[section]![crow]["cell"] == "\(mCutsomCell)"{
                    let cell = tableView.dequeueReusableCellWithIdentifier(mCutsomCell, forIndexPath: indexPath) as! CustsomMainTableViewCell
                        
                        cell.sectionName.text = rec_data[section]![crow]
                    return cell
                }else {
                    return UITableViewCell()
                }
        
      
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        testBool = true
        
        let section = indexPath.section
        let crow = indexPath.row
        var path : [NSIndexPath] = []
        if cellDic[section]![crow]["isAttached"] == "false" && cellDic[section]![crow]["cell"] == cellIndenty{
    
           for i in 1...countRowArr[section]{
               let p = NSIndexPath.init(forItem: crow + i, inSection: section)
               path.append(p)
           }

            //print("path in \(section) will init: \(path.count)")
            
            let ndic = ["cell":"systemCell", "isAttached":"true"]
            cellDic[section]![0] = ndic
            
            for _ in 0..<countRowArr[section]{
                let ndic = ["cell":"\(mCutsomCell)", "isAttached":"false"]
                cellDic[section]?.append(ndic)
            }
            
            //print("cellDic \(cellDic)")
    
            
            self.tableView.beginUpdates()
            self.tableView.insertRowsAtIndexPaths(path, withRowAnimation: UITableViewRowAnimation.Left)
            self.tableView.endUpdates() 
            
        }else if cellDic[section]![crow]["isAttached"] == "true" && cellDic[section]![crow]["cell"] == cellIndenty {
            
            let ndic = ["cell":"systemCell", "isAttached":"false"]
            cellDic[section]![0] = ndic
            
            for i in 1...countRowArr[section]{
                let p = NSIndexPath.init(forItem: crow + i, inSection: section)
                path.append(p)
            }
            
            for _ in 1...countRowArr[section]{
                cellDic[section]?.removeLast()
            }
            
            
            
            self.tableView.beginUpdates()
            self.tableView.deleteRowsAtIndexPaths(path, withRowAnimation: UITableViewRowAnimation.Left)
            self.tableView.endUpdates()
            
        }
        
        print("selected \(section), rows is \(crow)")
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        if cellDic[indexPath.section]![indexPath.row]["cell"]==cellIndenty{
            return 70
        }else{
            return 40
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
