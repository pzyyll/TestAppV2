//
//  PractiseQtypeBL.swift
//  TestApp
//
//  Created by Gatsby on 16/4/22.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

@objc
protocol PractiseQtypeBLDelegate {
    func getQtypeByCourseFinished(qtypes: [String: AnyObject])
    func getQtypeByCourseFail(fail: Bool)
}

class PractiseQtypeBL: NSObject, GRNetworkDelegateForQtype {
    
    var delegate: PractiseQtypeBLDelegate!
    
    override init() {
        super.init()
        GRNetwork.shareInstance.delegateForQtype = self
    }
    func getAllQtypeByCourse(course: Course) {
        GRNetwork.shareInstance.getQtypesByCourse(course)
    }
    
    func getQtypeFinished(qtypes: [String: AnyObject]) {
        self.delegate.getQtypeByCourseFinished(qtypes)
    }
    func getQtypeFail(fail: Bool) {
        self.delegate.getQtypeByCourseFail(fail)
    }
}
