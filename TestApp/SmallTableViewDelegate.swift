//
//  SmallTableViewDelegate.swift
//  TestApp
//
//  Created by Gatsby on 16/4/9.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class SmallTableViewDelegate:UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //let cell = tableView.dequeueReusableCellWithIdentifier("testcell",forIndexPath: indexPath)
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "testcell")
        cell.textLabel?.text = "hello"
        return cell
    }

}
