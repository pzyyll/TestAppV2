//
//  LoginBL.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/18.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

protocol LoginBLDelegate {
    func loginAuthority(ok: Bool)
}

class LoginBL: NSObject, UserInfoDelegate {
    
    var delegate: LoginBLDelegate!
    
    func login(user: UserInfo) {
        user.checkoutUser()
        user.delegate = self
    }
    
    func userInfoIsLegal(flag: Bool) {
        self.delegate.loginAuthority(flag)
    }
}
