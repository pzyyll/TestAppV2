//
//  UserInfo.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/18.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol UserInfoDelegate {
    func userInfoIsLegal(flag: Bool);
    func userInfoCheckoutFail(fail: Bool);
}

class UserInfo: NSObject, GRNetworkDelegateForUserInfo {
    var userName = ""
    var pwd = ""
    
    var delegate: UserInfoDelegate!
    
    func checkoutUser() {
        GRNetwork.shareInstance.delegateForUserInfo = self
        GRNetwork.shareInstance.checkoutUserInfo(self)
    }
    func checkoutUserInfoFinished(ok: Bool) {
        delegate.userInfoIsLegal(ok)
    }
    func checkoutUserInfoFail(fail: Bool) {
        delegate.userInfoCheckoutFail(fail);
    }
}
