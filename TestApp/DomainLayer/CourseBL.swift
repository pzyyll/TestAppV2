//
//  CourseBL.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/21.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

@objc
protocol CourseBLDelegate {
    optional func getCoursesFinished(courses: [Course]);
    optional func getCoursesDictFinished(courses: [String: [Course]])
    func loadingCoursesFail(fail: Bool);
}

class CourseBL: NSObject, GRNetworkDelegateForCourse {
    
    var delegate: CourseBLDelegate!

    override init() {
        super.init()
        GRNetwork.shareInstance.delegateForCourse = self
    }
    
    func getAllCourse() {
        GRNetwork.shareInstance.getAllCourses()
    }
    
    func getAllCourseDict() {
        GRNetwork.shareInstance.getAllCoursesDict()
    }
    
    func getAllCoursesFinished(courses: [Course]) {
        self.delegate.getCoursesFinished!(courses)
    }
    
    func getAllCoursesDictFinished(coursesDict: [String: [Course]]) {
        self.delegate.getCoursesDictFinished!(coursesDict)
    }
    
    func getAllCoursesFail(fail: Bool) {
        self.delegate.loadingCoursesFail(true);
    }
}
