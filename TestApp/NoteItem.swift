//
//  NoteItem.swift
//  samplenote
//
//  Created by CAIZHILI on 15/12/11.
//  Copyright © 2015年 CAIZHILI. All rights reserved.
//

import Foundation

func == (left: NoteItem, right: NoteItem) -> Bool {
    return (
        (left.title == right.title) &&
        (left.item == right.item) &&
        (left.date == right.date)
    )
}

class NoteItem {
    var title = ""
    var item = ""
    var date: NSDate?
    
    init () { }
    
    init (title: String, item: String) {
        self.title = title
        self.item = item
        
        self.date = NSDate()
    }
    
    func getDateTime() -> String {
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "HH:mm"
        return dateFormat.stringFromDate(self.date!)
    }
    func getDate() -> String {
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        return dateFormat.stringFromDate(self.date!)
    }
    
    func getStringDate() -> String? {
        let dateForm = NSDateFormatter()
        dateForm.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateForm.stringFromDate(self.date!)
    }
    
    func setDateFromString(date: String) {
        let dateForm = NSDateFormatter()
        dateForm.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.date = dateForm.dateFromString(date)
    }
}