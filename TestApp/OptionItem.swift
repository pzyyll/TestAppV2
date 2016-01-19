//
//  OptionItem.swift
//  TestApp
//
//  Created by CAIZHILI on 15/12/28.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import Foundation

class OptionItem {
    var no = ""
    var ans = ""
    var rights = ""
    var title = ""
    var options : [String]?
    
    init() {
        self.options = [String]()
    }
    
    init(title: String, options: [String]) {
        self.title = title
        self.options = options
    }
}