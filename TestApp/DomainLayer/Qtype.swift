//
//  Qtype.swift
//  TestApp
//
//  Created by Gatsby on 16/4/22.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class Qtype: NSObject {
    var qtt_No = ""
    var c_No = ""
    var qtt_NameCn = ""
    var qtt_NameEn = ""
    var qtt_Aut = 0
    var qt_Type = ""
    var qt_TypeCn = ""
    var qt_Aut = 0
    var qt_No = ""
    
    init(dict: [String: AnyObject]) {
        if let str = dict["qtt_No"] as? String {
            self.qtt_No = str;
        }
        
        if let str = dict["c_No"] as? String {
            self.c_No = str;
        }
        if let str = dict["qtt_NameCn"] as? String {
            self.qtt_NameCn = str;
        }
        if let str = dict["qtt_NameEn"] as? String {
            self.qtt_NameEn = str;
        }
        if let numstr = dict["qtt_Aut"] as? String {
            self.qtt_Aut = Int(numstr)!;
        }
        if let str = dict["qt_Type"] as? String {
            self.qt_Type = str;
        }
        if let str = dict["qt_TypeCn"] as? String {
            self.qt_TypeCn = str;
        }
        if let numstr = dict["qt_Aut"] as? String {
            self.qt_Aut = Int(numstr)!;
        }
        if let str = dict["qt_No"] as? String {
            self.qt_No = str;
        }
    }
}
