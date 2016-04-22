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
        if let str = dict["epType"] as? Int {
            self.ep_Type = str
        }
    }
}