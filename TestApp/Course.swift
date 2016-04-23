//
//  Course.swift
//  TestApp
//
//  Created by CAIZHILI on 15/12/27.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import Foundation

let DefaultCourse = "\(identifier_Keychain)defaultCourse"

class Course: NSObject {
    var l_No = ""
    var l_Name = ""
    var c_No = ""
    var c_Name = ""
    var c_Intro = ""
    var c_Appdendtime = ""
    var c_IntroEn = ""
    
    var courseNo = ""
    var courseName = ""
    var courseIntro = ""

    override init() {
        super.init()
    }
    
    init(dict: [String: AnyObject]) {
        if let str = dict["l_No"] as? String {
            self.l_No = str
        }
        if let str = dict["l_Name"] as? String {
            self.l_Name = str
        }
        if let str = dict["c_No"] as? String {
            self.c_No = str
        }
        if let str = dict["c_Introduction"] as? String {
            self.c_Intro = str
        }
        if let str = dict["c_AppdendTime"] as? String {
            self.c_Appdendtime = str
        }
        if let str = dict["c_Name"] as? String {
            self.c_Name = str
        }
        if let str = dict["c_IntroEn"] as? String {
            self.c_IntroEn = str
        }
        super.init()
    }
    
    class func getCoursesDefault() -> Course {
        let index = NSUserDefaults.standardUserDefaults().valueForKey(DefaultCourse) as? [String]
        if index != nil {
            return Course(dict: ["c_No": index![0], "c_Introduction": index![1]])
        }
        return Course(dict: ["c_No": "c00001", "c_Introduction": "大学英语四级"])
    }
}