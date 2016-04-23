//
//  ExamPaper.swift
//  TestApp
//
//  Created by CAIZHILI on 15/12/27.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import Foundation

class ExamPaper: NSObject {
    var NO = ""
    var name = ""
    var addTime = ""
    
    
    //*****************
    var ep_No = ""
    var c_No = ""
    var ep_Name = ""
    var ep_PublishTime = ""
    var ep_Type = 0
    
    override init() {
        super.init()
    }
    
    init(dict: [String: AnyObject]) {
        if let str = dict["ep_No"] as? String {
            self.ep_No = str
        }
        if let str = dict["c_No"] as? String {
            self.c_No = str
        }
        if let str = dict["ep_Name"] as? String {
            self.ep_Name = str
        }
        if let str = dict["ep_PublishTime"] as? String {
            self.ep_PublishTime = str
        }
        if let str = dict["ep_Type"] as? String {
            self.ep_Type = Int(str)!
        }
    }
    
    func getDate() -> String {
        let dataF = NSDateFormatter()
        dataF.dateFormat = "yyyyMMdd"
        var datestr = self.ep_No
        if datestr.characters.last! == "m" {
            datestr.removeAtIndex(datestr.endIndex.predecessor())
        }
        let date = dataF.dateFromString(datestr)
        dataF.dateFormat = "yyyy年MM月"
        let str = dataF.stringFromDate(date!)
        return str
    }
}