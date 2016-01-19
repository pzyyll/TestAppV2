//
//  Timer.swift
//  TestApp
//
//  Created by CAIZHILI on 15/12/29.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import Foundation

class Timer {
    var hour = 0
    var sec = 0
    var timer: NSTimer?
    
    func getSecString() -> String {
        if String(self.sec).characters.count < 2 {
            return String(format: "%02d", self.sec)
        }
        return String(self.sec)
    }
    
    func getHourString() -> String {
        if String(self.hour).characters.count < 2 {
            return String(format: "%02d", self.hour)
        }
        return String(self.hour)
    }
    
    func update() {
        if self.sec == 60 {
            self.hour++
            self.sec = 0
        }
    }
}