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

enum Router: URLRequestConvertible {
    static let baseURLString = "http://localhost/ios/TServices"
    
    case QueryUser(UserInfo)
    case RegUser(UserInfo)
    case GetUser(UserInfo)
    
    var method: Alamofire.Method {
        switch self {
        case .QueryUser(_):
            return .POST
        case .RegUser(_):
            return .POST
        case .GetUser(_):
            return .GET
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        let (path, parameters) = {
            ()->(String, [String: AnyObject]) in
            switch self {
            case .QueryUser(let user):
                let params = ["user": user.userName,
                             "pwd": user.pwd,
                             "uuid": UIDevice.currentDevice().identifierForVendor!.UUIDString]
                return ("/login.php",params)
            case .RegUser(let user):
                let params = ["user": user.userName,
                              "pwd": user.pwd]
                return ("/reg.php", params)
            case .GetUser(let user):
                let params = ["user": user.userName]
                return ("/getUser.php", params)
            }
        }()
        
        let url = NSURL(string: Router.baseURLString)
        let urlRequest = NSMutableURLRequest(URL: url!.URLByAppendingPathComponent(path))
        urlRequest.HTTPMethod = self.method.rawValue
        let encoding = Alamofire.ParameterEncoding.URL
        return encoding.encode(urlRequest, parameters: parameters).0
    }
}


protocol UserInfoDelegate {
    func userInfoIsLegal(flag: Bool);
}

class UserInfo: NSObject, GRNetworkDelegateForUserInfo {
    var userName = ""
    var pwd = ""
    
    var delegate: UserInfoDelegate!
    
    func checkoutUser() {
        GRNetwork.shareInstance.delegateForUserInfo = self
        GRNetwork.shareInstance.checkoutUserInfo(self)
    }
    func checkoutUserInfoFinished(flag: Bool) {
        delegate.userInfoIsLegal(flag)
    }
}
