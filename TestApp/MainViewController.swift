//
//  MainViewController.swift
//  samplenote
//
//  Created by CAIZHILI on 15/12/11.
//  Copyright © 2015年 CAIZHILI. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, TransData {
    
    var noteLibary = NSMutableArray()
    var searchRes = NSMutableArray()
    var mainTableView: UITableView?
    let identify = "aCell"
    
    var toolbar: UIToolbar?
    var searchBar: UISearchBar?
    
    override func loadView() {
        super.loadView()
        
        self.noteLibary.addObject(NoteItem(title: "abc", item: "abc"))
        print("loadView")
        self.searchRes = self.noteLibary.mutableCopy() as! NSMutableArray
        //init search bar
        self.title = "备忘录"

        //self.toolbar = UIToolbar(frame: CGRectMake(0, 64, self.view.frame.width, 30))
        //self.view.addSubview(self.toolbar!)
        
        var rect = CGRect(x: 0, y: 68, width: self.view.frame.width, height: 30)
        self.searchBar = UISearchBar(frame: rect)
        
        rect = self.view.frame
        rect.origin.y = 30
        self.mainTableView = UITableView(frame: rect, style: .Grouped)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
//        self.noteLibary = NSMutableArray()
//        self.noteLibary.append(NoteItem(title: "abc", item: "abc"))
//        self.noteLibary.append(NoteItem(title: "abc", item: "abc"))
//        self.noteLibary.append(NoteItem(title: "abc", item: "abc"))
        
        
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)

        let addBtn = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("addNewNote"))
        self.toolbar?.setItems([spaceBtn, addBtn], animated: true)
        
        
        //add btn
        self.navigationItem.rightBarButtonItem = addBtn
        
        
        self.mainTableView?.delegate = self
        self.mainTableView?.dataSource = self
        
        self.mainTableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: identify)
        
        if (self.noteLibary.count == 0) {
            let notAnyThing = UILabel(frame: CGRectMake(0, 0, self.view.frame.width, 30))
            notAnyThing.text = "Not any thing"
            notAnyThing.textAlignment = .Center
            notAnyThing.center = self.view.center
            notAnyThing.backgroundColor = UIColor.clearColor()
            notAnyThing.textColor = UIColor.darkGrayColor()
            notAnyThing.font = UIFont.systemFontOfSize(20)
            self.view.addSubview(notAnyThing)
        } else {
            self.view.addSubview(mainTableView!)
            self.view.addSubview(self.searchBar!)
        }
            // Do any additional setup after loading the view.
        
        //search bar
        //self.searchBar?.barTintColor = UIColor.whiteColor()
        self.searchBar?.searchBarStyle = .Minimal
        self.searchBar?.delegate = self
        //self.searchBar?.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.searchRes.count)
        return self.searchRes.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let data = self.searchRes[indexPath.row] as! NoteItem
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: self.identify)
        cell.accessoryType = .DisclosureIndicator
        //cell.accessoryView = UIImageView(image: UIImage(named: "add"))
        cell.textLabel?.text = data.title
        cell.backgroundColor = UIColor.clearColor()
        cell.detailTextLabel?.text = data.getDateTime()
        
        print("1")
        return cell
    }
    
    //以下两个函数必须同时实现
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textAlignment = .Center
        titleLabel.text = (self.noteLibary[0] as! NoteItem).getDate()
        titleLabel.font = UIFont.systemFontOfSize(12)
        titleLabel.textColor = UIColor.darkGrayColor()
        
        return titleLabel
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func addNewNote() {
        let edit = EditViewController()
        edit.sendtoDelegate = self
        edit.title = "New"
        self.navigationController?.pushViewController(edit, animated: true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.searchRes = self.noteLibary.mutableCopy() as! NSMutableArray
        } else {
            self.searchRes.removeAllObjects()
            for item in self.noteLibary {
                if (item as! NoteItem).title.hasPrefix(searchText) {
                    self.searchRes.addObject(item)
                }
            }
        }
        
        //self.searchRes.sortUsingComparator(sortDate)
        self.mainTableView?.reloadData()
    }
    
    func sendAItem(aNote: NoteItem) {
        self.noteLibary.addObject(aNote)
        self.noteLibary.sortUsingComparator(sortDate)
        self.searchRes = self.noteLibary.mutableCopy() as! NSMutableArray
        self.searchRes.sortUsingComparator(sortDate)
        self.mainTableView!.reloadData()
    }
    
    func sortDate(m1: AnyObject!, m2: AnyObject!) -> NSComparisonResult {
        if (m1 as! NoteItem).date!.timeIntervalSince1970 >
            (m2 as! NoteItem).date!.timeIntervalSince1970 {
                return NSComparisonResult.OrderedAscending
        } else {
            return NSComparisonResult.OrderedDescending
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        var data = NoteItem()
        for detailNoteItem in self.noteLibary {
            let temp = self.searchRes[indexPath.row] as! NoteItem
            if (temp == (detailNoteItem as! NoteItem)) {
                data = detailNoteItem as! NoteItem
                break
            }
        }
        
        let detailView = DetailViewController()
        detailView.detailNoteItem = data
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

//    func rowsForNoteTable(tableView: TableView) -> Int {
//        return self.noteLibary.count
//    }
//    
//    func NoteTableView(tableView: TableView, dataForRow row: Int) -> NoteItem
//    {
//        return self.noteLibary[row]
//    }
    
}
