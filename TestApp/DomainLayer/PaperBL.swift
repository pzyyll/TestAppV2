//
//  PaperBL.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/23.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

@objc
protocol PaperBLDelegate {
    func getAllPapersFinished(papersDict: [String: AnyObject])
    func getAllPapersFail(fail: Bool)
}

class PaperBL: NSObject, GRNetworkDelegateForPapers {

    var delegate: PaperBLDelegate!
    
    override init() {
        super.init()
        GRNetwork.shareInstance.delegateForPaper = self
    }
    
    func getAllPapers(course: Course, type: Int) {
        GRNetwork.shareInstance.getPaterByCourse(course, type: type)
    }
    
    func getPapersFinished(papersDict: [String : AnyObject]) {
        self.delegate.getAllPapersFinished(papersDict)
    }
    
    func getPapersFail(fail: Bool) {
        self.delegate.getAllPapersFail(fail)
    }
}
