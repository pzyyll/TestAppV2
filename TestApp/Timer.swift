//
//  Timer.swift
//  TestApp
//
//  Created by CAIZHILI on 15/12/29.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import Foundation

class Timer: NSObject {
    var hour = 0
    var sec = 0
    var enable = false
    var timer: NSTimer?
    
    override init() {
        super.init()
        self.addObserver(self, forKeyPath: "sec", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
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
        if self.sec >= 60 {
            self.hour += self.sec / 60
            self.sec = self.sec % 60
        }
    }
    
    func update_d() {
        if self.sec == 0 && self.hour != 0 {
            self.sec = 59
            self.hour -= 1
        } else if self.sec != 0 {
            self.sec -= 1
        } else if self.sec == 0 && self.hour == 0 {
            self.sec -= 1
        }
    }
    
    func fire() {
        self.timer?.fire()
    }
    
    func startRunLoop() {
        NSRunLoop.mainRunLoop().addTimer(self.timer!, forMode: NSDefaultRunLoopMode)
    }
    func stop() {
        self.timer?.invalidate()
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "sec" {
            if self.hour > 0 || self.sec > 0 {
                self.enable = true
            } else {
                self.enable = false
            }
        }
    }
    
}