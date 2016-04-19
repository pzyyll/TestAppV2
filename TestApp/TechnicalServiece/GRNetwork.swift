//
//  GRNetwork.swift
//  TestApp
//
//  Created by caizhili on 16/4/18.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

@objc
protocol GRNetworkDelegateForUserInfo {
    func checkoutUserInfoFinished(flag: Bool);
    optional func checkoutUserInfoFail(flag: Bool);
}

class GRNetwork: NSObject {
    
    //URLRequestConvertible
    //单例模式
    class var shareInstance: GRNetwork {
        struct Static {
            static var instance: GRNetwork?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) { 
            Static.instance = GRNetwork()
        }
        
        return Static.instance!
    }
    
    var delegateForUserInfo: GRNetworkDelegateForUserInfo!
    
    func checkoutUserInfo(user: UserInfo) {
        Alamofire.request(Router.QueryUser(user)).responseJSON { (response) in
            let json = JSON(data: response.data!);
            let ok = json["status"].int
            print(json)
            print(ok!)
            self.delegateForUserInfo.checkoutUserInfoFinished(ok! == 1);
        }
    }
}
