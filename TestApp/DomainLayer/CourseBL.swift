//
//  CourseBL.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/21.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

protocol CourseBLDelegate {
    func getCoursesFinished(courses: [Course]);
    func loadingCoursesFail(fail: Bool);
}

class CourseBL: NSObject, GRNetworkDelegateForCourse {
    
    var delegate: CourseBLDelegate!

    func getAllCourse() {
        GRNetwork.shareInstance.getAllCourses()
        GRNetwork.shareInstance.delegateForCourse = self
    }
    
    func getAllCoursesFinished(courses: [Course]) {
        self.delegate.getCoursesFinished(courses)
    }
    
    func getAllCoursesFail(fail: Bool) {
        self.delegate.loadingCoursesFail(true);
    }
}
