//
//  RegBL.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/21.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

@objc
protocol RegBLDelegate {
    optional func regUserIsExists(exists: Bool);
    optional func regUserIsFinished(ok: Bool);
    optional func queryFail(fail: Bool);
}

class RegBL: NSObject, GRNetworkDelegateForUserInfo {
    
    var delegate: RegBLDelegate!
    
    override init() {
        super.init()
        GRNetwork.shareInstance.delegateForUserInfo = self
    }
    
    func getCode(user: UserInfo) -> String {
        return ""
    }
    
    func queryUser(user: UserInfo) {
        GRNetwork.shareInstance.queryUser(user)
    }
    
    func regUser(user: UserInfo) {
        GRNetwork.shareInstance.regUser(user)
    }
    
    func queryUserIsExists(exists: Bool) {
        self.delegate.regUserIsExists!(exists)
    }
    
    func queryUserIsExistsFail(fail: Bool) {
        self.delegate.queryFail!(fail)
    }
    
    func regUserFinished(ok: Bool) {
        self.delegate.regUserIsFinished!(ok)
    }
    
    func regUserFail(fail: Bool) {
        self.delegate.queryFail!(true)
    }
}
